//
//  Card.swift
//  Set
//
//  Created by Wangshu Zhu on 2018/7/18.
//  Copyright © 2018年 Wangshu Zhu. All rights reserved.
//

import Foundation

struct Card: CustomStringConvertible, Equatable {
    
    var symbol:Symbol
    var number:Number
    var shading:Shading
    var color:Color
    
    enum Symbol: String {
        case triangle = "▲"
        case square = "◼"
        case circle = "●"
        
        static let all = [Symbol.triangle, .square, .circle]
    }
    
    enum Number: Int {
        case one = 1
        case two = 2
        case three = 3
        
        static let all = [Number.one, .two, .three]
        
       
    }
    
    enum Shading: String {
        case striped = "Striped"
        case solid = "Solid"
        case open = "Open"
        
        static let all = [Shading.striped, .solid, .open]
    }
    
    enum Color: String {
        case red = "Red"
        case blue = "Blue"
        case black = "Black"
        
        static let all = [Color.red, .blue, .black]
    }
    
    internal var description: String {
        let des = "color: \(self.color) number: \(self.number) Symbol: \(self.symbol) shading: \(self.shading)"
        return des
    }
    
}

extension Card {
    static func match(for cardArray: Array<Card>) -> Bool {
        
        let colorCount = Set(cardArray.map{ $0.color }).count
        let shadingCount = Set(cardArray.map {$0.shading}).count
        let symbolCount = Set(cardArray.map {$0.symbol}).count
        let numberCount = Set(cardArray.map {$0.number}).count
        
        return colorCount != 2 && shadingCount != 2 && symbolCount != 2 && numberCount != 2
    }
    
}
