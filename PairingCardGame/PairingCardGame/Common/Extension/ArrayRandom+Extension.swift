//
//  ArrayRandom+Extension.swift
//  PairingCardGame
//
//  Created by Berk Batuhan ŞAKAR on 28.11.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import GameKit

// MARK: - Extension to shuffle Arrays
extension Array {

    /// Mutate array by a random shuffle using GameKit.
    ///
    /// - Parameter seed: start point for pseudorandom.
    mutating func shuffled(seed: UInt64? = nil) {
        if let seed = seed,
            let array = GKMersenneTwisterRandomSource(seed: seed).arrayByShufflingObjects(in: self) as? Array {
            self = array
        } else if let array = GKMersenneTwisterRandomSource().arrayByShufflingObjects(in: self) as? Array {
            self = array
        }
    }
}
