//
//  CardModel.swift
//  MatchGame
//
//  Created by Caio on 28/03/20.
//  Copyright © 2020 Caio. All rights reserved.
//

import Foundation

public class CardModel {
    
    func getCards() -> [Card]{
        var cards = [Card]()
        let selectedCards = [Int]()
        while cards.count < 15{
            let cardNumber = arc4random_uniform(13) + 1
            if(!selectedCards.contains(Int(cardNumber))){
                cards.append(Card("card\(cardNumber)"))
                cards.append(Card("card\(cardNumber)"))
            }
        }
        
        return cards.shuffled()
    }
    
}
