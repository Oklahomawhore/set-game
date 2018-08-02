//
//  cardDeck.swift
//  Set
//
//  Created by Wangshu Zhu on 2018/7/29.
//  Copyright © 2018年 Wangshu Zhu. All rights reserved.
//

import Foundation

struct CardDeck{
    private(set) var cards = [Card]()
    
    mutating func draw() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
    
    //initialize a full deck
    init() {
        for symbol in Card.Symbol.all {
            for color in Card.Color.all {
                for shading in Card.Shading.all {
                    for number in Card.Number.all {
                        let cardCreated = Card(symbol: symbol, number: number, shading: shading, color: color)
                        cards.append(cardCreated)
                    }
                }
            }
        }
        
        
    }
    
    
    
}
