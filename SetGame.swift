//
//  Set.swift
//  Set
//
//  Created by Wangshu Zhu on 2018/7/18.
//  Copyright © 2018年 Wangshu Zhu. All rights reserved.
//

import Foundation

struct SetGame {
    //vars
    var cardDeck = CardDeck()
    var selectedCards = [Card]()
    var matchedCards = [Card]()
    private let dealCardsNumber = 3
    private let firstTimeDealCardNumber = 12
    var score = 0
    
    private(set) var cardsOnTable = [Card]()
    private(set) var hintCards = [Card]()
    
    //funcs
    
    mutating func chooseCard(at index:Int) {
        if index < cardsOnTable.count{
            if selectedCards.contains(cardsOnTable[index]) {
                selectedCards.remove(at: selectedCards.index(of: cardsOnTable[index])!)
                return
            } else {
                if !matchedCards.contains(cardsOnTable[index]) {
                    if selectedCards.count == 3 {
                        if Card.match(for: selectedCards) {
                            matchedCards += selectedCards
                            //                        for cards in selectedCards {
                            //                            cardsOnTable.remove(at: cardsOnTable.index(of: cards)!)
                            //                        }
                            score += 5
                            print ("Congratulations! selected cards are a set")
                        } else {
                            score -= 3
                            print ("selected cards are not a set")
                        }
                        selectedCards.removeAll()
                    } else {
                        selectedCards.append(cardsOnTable[index])
                    }
                    
                } else {
                    //dose nothing
                    print("selected already matched card")
                }
            }
        } else {
            print("selected card not on table")
        }
        
    }
    
    mutating func drawCards() -> Card? { //draw 1 card from deck
       return cardDeck.draw()
    }
    
    mutating func provideHint(){
        if !hintCards.isEmpty{
            hintCards.removeFirst(3)
        }
        var cardsOnTableExceptMatched = [Card]()
        for index in cardsOnTable.indices{
            if !matchedCards.contains(cardsOnTable[index]){
                cardsOnTableExceptMatched += [cardsOnTable[index]]
            }
        }
        
        
        for i in 0..<cardsOnTableExceptMatched.count{
            for j in i+1..<cardsOnTableExceptMatched.count {
                for k in j+1..<cardsOnTableExceptMatched.count {
                    if Card.match(for: [cardsOnTableExceptMatched[i],cardsOnTableExceptMatched[j],cardsOnTableExceptMatched[k]]) {
                        hintCards += [cardsOnTableExceptMatched[i],cardsOnTableExceptMatched[j],cardsOnTableExceptMatched[k]]
                        print ("hint found")
                    }
                }
            }
        }
        
        
    }
    
    mutating func dealThreeMore() {
        for _ in 0..<3 {
            if let cardToAppend = drawCards() {
                cardsOnTable.append(cardToAppend)
            } else {
                print("SetGame: deal card failed due to unrecognized reason")
            }
        }
    }
    
    init() {
        for _ in 0..<12 {
            if let cardToAppend = drawCards() {
                cardsOnTable.append(cardToAppend)
            } else {
                print("SetGame: init failed, card deck out of cards")
            }
        }
    }
}

extension Int {
    var arc4random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}


