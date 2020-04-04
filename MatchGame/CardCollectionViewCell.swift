//
//  CardCollectionViewCell.swift
//  MatchGame
//
//  Created by Caio on 28/03/20.
//  Copyright © 2020 Caio. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?
    
    func setCard(_ card: Card){
        self.card = card
        frontImageView.image = UIImage(named: card.imageName)
        frontImageView.alpha = card.isMatched ? 0 : 1
        backImageView.alpha = card.isMatched ? 0 : 1
        let isFlipped = card.isFlipped

        UIView.transition(from: isFlipped ? backImageView : frontImageView,
        to: isFlipped ? frontImageView: backImageView,
        duration: 0,
        options: [.showHideTransitionViews, .transitionFlipFromLeft],
        completion: nil)
    }
    
    func flip (){
        if !(card!.isMatched) {
            card!.isFlipped = !card!.isFlipped
            let isFlipped = card!.isFlipped
            print(isFlipped)
            UIView.transition(from: isFlipped ? backImageView : frontImageView,
                              to: isFlipped ? frontImageView: backImageView,
                              duration: 0.3,
                              options: [.showHideTransitionViews, .transitionFlipFromLeft],
                              completion: nil)
        }
    }
    
    func remove (){
        UIView.animate(withDuration: 0.3, delay: 0.5, options: [.curveEaseOut], animations: {
            self.frontImageView.alpha = 0
            self.backImageView.alpha = 0
        }, completion: nil)
    }
}
