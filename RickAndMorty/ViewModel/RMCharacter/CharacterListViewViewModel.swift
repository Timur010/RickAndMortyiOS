//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by timur on 08.02.2023.
//


import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters (with newIndexPath: [IndexPath])
    func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharacterListViewViewModel: NSObject {
    public weak var delegate : RMCharacterListViewViewModelDelegate?
    private var isLoadingMoreCharacter = false
    private var cellViewModel: [RMCharacterCollectionViewCellViewModel] = []
    private var apiInfo: RMGetAllCharacterResponse.Info? = nil
    private var character: [RMCharacter] = [] {
        didSet {
            for character in character {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImage: URL(string: character.image)
                )
                if !cellViewModel.contains(viewModel) {
                    cellViewModel.append(viewModel)
                }
            }
        }
    }

    public func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharacterResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                self?.character = responseModel.results
                self?.apiInfo = responseModel.info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchAdditionalCharacter(url: URL) {
        guard !isLoadingMoreCharacter else {
            return
        }
        isLoadingMoreCharacter = true
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacter = false
            return
        }
        RMService.shared.execute(request, expecting: RMGetAllCharacterResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                strongSelf.apiInfo =  responseModel.info
                
                let originalCount = strongSelf.character.count
                let newCount = responseModel.results.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indexPathToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                print(indexPathToAdd)
                strongSelf.character.append(contentsOf: responseModel.results)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(with: [] )
                    strongSelf.isLoadingMoreCharacter = false
                }
            case .failure(let failure):
                print(String(String(describing: failure)))
                self?.isLoadingMoreCharacter = false
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
                let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                    for: indexPath
                ) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startanimation()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = character[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacter,
              !cellViewModel.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString)
        else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 100) {
                self?.fetchAdditionalCharacter(url: url)
            }
            t.invalidate()
        }
    }
}
