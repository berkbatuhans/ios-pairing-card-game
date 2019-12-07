//
//  Card.swift
//  PairingCardGame
//
//  Created by Berk Batuhan ŞAKAR on 28.11.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import Foundation
import UIKit

struct Card {
    
    init() {
        self.identifier = UUID().uuidString
    }
    init(card: Card) {
        self.identifier = card.identifier
        self.shown = card.shown
        self.image = card.image
    }
    
    var identifier: String
    var image: UIImage!
    var shown = false
}

// MARK: - Actions.
extension Card {
    func getCopy() -> Card {
        return Card(card: self)
    }
    func isMatch(of card: Card) -> Bool {
        return card.image == image
    }
}

// MARK: - Equatable
extension Card : Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
