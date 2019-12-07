//
//  GameCollectionView.swift
//  PairingCardGame
//
//  Created by Berk Batuhan ŞAKAR on 28.11.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import UIKit

class GameCollectionView: UICollectionView {
    
    var game: GameViewModel?
    
    override func awakeFromNib() {
        delegate = self
        dataSource = self
        prefetchDataSource = self
    }
    
}

// MARK: - Data Source
extension GameCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game!.amountOfCards()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as? CardCell else {
            fatalError("Developer: Error casting CardCell")
        }
        cell.show(animated: false)
        guard let card = game!.card(at: indexPath.item) else { return cell }
        cell.card = card
        cell.backgroundColor = .clear
        return cell
    }
    
    
}

// MARK: - Collection Layout
extension GameCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let amountPerRow = CGFloat(Int(sqrt(Double(game!.amountOfCards()))))
        let interSpaces = (10*(amountPerRow-1))
        let availableSpace = collectionView.frame.width - interSpaces
        let itemWidth = availableSpace / amountPerRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

// MARK: - User Actions
extension GameCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell else {
            fatalError("Developer: Error casting CardCell")
        }
        guard !cell.shown, let card = cell.card else { return }
        game!.didSelect(card: card)
    }
}

extension GameCollectionView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    }
}


