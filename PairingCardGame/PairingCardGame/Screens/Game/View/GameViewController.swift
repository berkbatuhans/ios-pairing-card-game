//
//  ViewController.swift
//  PairingCardGame
//
//  Created by Berk Batuhan ŞAKAR on 27.11.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import UIKit
import AppCenter
import AppCenterCrashes
import AppCenterAnalytics

class GameViewController: UIViewController {
    @IBOutlet fileprivate final weak var collectionView: GameCollectionView!
    
    var game = GameViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.view = self
        configurateCollectionView()
        MSAppCenter.start("01ff9ee3-49aa-453f-a921-a5afadb693c9", withServices:[
          MSCrashes.self,
          MSAnalytics.self
        ])
    }
    
    private func configurateCollectionView() {
        
        collectionView.register(UINib(nibName: CardCell.identifier, bundle: .main), forCellWithReuseIdentifier: CardCell.identifier)
//        collectionView.backgroundColor = .clear
        collectionView.game = game
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}

// MARK: - ViewModel input communication
extension GameViewController {
    

    
    func reloadCollection() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func show(cards: [Card]) {
        MSAnalytics.trackEvent("Kart Gösterilme Fonksiyonu Tetiklendi.")
        for card in cards {
            let index = game.index(for: card)
            let cell = collectionView.cellForItem(at: IndexPath(item: index!,section: 0)) as! CardCell
            DispatchQueue.main.async {
                cell.show(animated: true)
            }
        }
    }
    
    func hide(cards: [Card]) {
        for card in cards {
            let index = game.index(for: card)
            let cell = collectionView.cellForItem(at: IndexPath(item: index!, section: 0)) as? CardCell
            cell?.show(animated: true)
        }
    }
    
}

extension GameViewController : GameViewProtocol {
    func startGame() {
        game.startGame()
    }
    
    func index(for card: Card) -> Int? {
        return game.index(for: card)
    }
    
    func card(at index: Int) -> Card? {
        return game.card(at: index)
    }
    
    func didSelect(card: Card) {
        game.didSelect(card: card)
    }
    
    func amountOfCards() -> Int {
        return game.amountOfCards()
    }
    
    func gameDidStart(with deck: [Card]) {
        game.gameDidStart(with: deck)
    }
    
    func gameDidFinish() {
        game.gameDidFinish()
    }
    
    func match() {
        game.match()
    }
    
    func startGame(cardsAmount: Int) {
        game.startGame(cardsAmount: cardsAmount)
    }
    
    
}

