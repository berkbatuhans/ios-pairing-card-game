//
//  GameProtocol.swift
//  PairingCardGame
//
//  Created by Berk Batuhan ŞAKAR on 28.11.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import Foundation


protocol GameViewProtocol: class {
    func reloadCollection()
//    var view: GameViewProtocol? { get set }
    
    func startGame()
    func index(for card: Card) -> Int?
    func card(at index: Int) -> Card?
    func didSelect(card: Card)
    func amountOfCards() -> Int
    
    func gameDidStart(with deck: [Card])
    func gameDidFinish()
    func match()
    func show(cards: [Card])
    func hide(cards: [Card])
    
    func startGame(cardsAmount: Int)
    
}
