//
//  CardCell.swift
//  PairingCardGame
//
//  Created by Berk Batuhan ŞAKAR on 28.11.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    private let animationDuration = 0.5
    private(set) var shown = false
    var card: Card?
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView! {
        didSet{
            backImageView.image = UIImage(named: "card_back")

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

// MARK: - Add Subviews.
extension CardCell {

    private func addImage() {
        guard let card = card else { return }
        frontImageView.image = card.image
    }

}


// MARK: - Actions.
extension CardCell {
    func show(animated: Bool) {
        frontImageView.image = nil
        addImage()
        
        frontImageView.isHidden = false
        backImageView.isHidden = false
        shown = !shown
        
        animated ? flipAnimated() : flip()
    }
    
    private func flip() {
        if shown {
            bringSubviewToFront(frontImageView)
            backImageView.isHidden = true
        } else {
            bringSubviewToFront(backImageView)
            frontImageView.isHidden = true
        }
    }

    private func flipAnimated() {
        if shown {
            UIView.transition(from: backImageView,
                              to: frontImageView,
                              duration: animationDuration,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        } else {
            UIView.transition(from: frontImageView,
                              to: backImageView,
                              duration: animationDuration,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        }
    }
}
