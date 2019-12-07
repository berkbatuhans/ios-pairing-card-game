//
//  GameViewModel.swift
//  PairingCardGame
//
//  Created by Berk Batuhan ŞAKAR on 28.11.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import Foundation
import UIKit

final class GameViewModel {
    
    
    var view: GameViewProtocol?
    init() {
        startGame()
    }
    
    private var deck = [Card]()
    
    private var matchedCards = [Card]()
    private var shownCards = [Card]()
    private var cardsAmount = 0
}


// MARK: - Game life cycle.
extension GameViewModel {
    func startGame() {
        startGame(cardsAmount: amountOfCards())
    }
    func gameDidStart(with deck: [Card]) {
        self.deck = deck
//        view?.reloadCollection()
    }
    
    func gameDidFinish() {
        deck.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.startGame()
        }
    }
    func match() {
    }
    
    
    
    
    
    
    
    
}

// MARK: - Output actions.
extension GameViewModel {
    
    func didSelect(card: Card) {
        view?.show(cards: [card])
        didSelectLogic(card: card)
    }
    
    func show(cards: [Card]) {
        view?.show(cards: cards)
    }
    
    func hide(cards: [Card]) {
        view?.hide(cards: cards)
    }
}

// MARK: - Data.
extension GameViewModel {
    func card(at index: Int) -> Card? {
        guard deck.count > index && index >= 0 else { return nil }
        return deck[index]
    }
    func index(for card: Card) -> Int? {
        return deck.index(of: card)
    }
    func amountOfCards() -> Int {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 24
        case .pad:
            return 48
        default:
            return -1
        }
    }
}


extension GameViewModel {
    func startGame(cardsAmount: Int) {
        self.cardsAmount = cardsAmount
        let deck = createDeck()
        gameDidStart(with: deck)
    }
    func checkGameStatus() {
        if matchedCards.count == cardsAmount {
            gameDidFinish()
            resetGame()
        } else {
            match()
        }
    }
    
    func resetGame() {
        matchedCards.removeAll()
        shownCards.removeAll()
    }
}

extension GameViewModel {
    func createDeck(seed: UInt64? = nil) -> [Card] {
        var deck = [Card]()
        let card = Card()
        let randomCards = 12
        for _ in 1...randomCards {
            deck.append(contentsOf: [card, card.getCopy()]) // create card, and a pair.
        }
        
        deck.shuffled(seed: seed)
        return deck
    }
}


// MARK: - Memory Game Game Logic
extension GameViewModel {

    func didSelectLogic(card: Card) {

        guard let unpaired = unpairedCard() else {
            // There are not enoght showed cards.
            shownCards.append(card)
            return
        }

        guard card.isMatch(of: unpaired) else {
            // Is not a match.
            isNotMatch(of: [card, unpaired])
            return
        }

        // Is a match!
        isMatch(of: [card, unpaired])
    }

    private func isNotMatch(of cards: [Card]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.view?.hide(cards: cards)
        }
    }

    private func isMatch(of cards: [Card]) {
        matchedCards.append(contentsOf: cards)
        checkGameStatus()
    }

    private func unpairedCard() -> Card? {
        guard shownCards.count > 0 else { return nil }
        return shownCards.removeLast()
    }

}
