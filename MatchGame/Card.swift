//
//  Card.swift
//  MatchGame
//
//  Created by Caio on 28/03/20.
//  Copyright © 2020 Caio. All rights reserved.
//

import Foundation

public class Card{
    var imageName = ""
    var isFlipped = false
    var isMatched = false
    
    init (_ imageName: String){
        self.imageName = imageName
    }
    
}
