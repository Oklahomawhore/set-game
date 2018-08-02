//
//  ViewController.swift
//  Set
//
//  Created by Wangshu Zhu on 2018/7/18.
//  Copyright © 2018年 Wangshu Zhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //vars
    var set = SetGame()
    private var selectedButtons = [UIButton]()
    private var hintedButons = [UIButton]()
    private var matchedButtons = [UIButton]()
    
    //IBOutlets
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var threeMoreButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    
    
    //IBActions
    @IBAction func cardButtonTouched(_ sender: UIButton) {
        if let cardIndex = cardButtons.index(of: sender) {
            set.chooseCard(at: cardIndex)
            for matchedIndex in set.matchedCards.indices {
                matchedButtons += [cardButtons[set.cardsOnTable.index(of: set.matchedCards[matchedIndex])!]]
            }
            //append selected cards
            if !selectedButtons.contains(sender) {
                if selectedButtons.count < 3 {
                    selectedButtons.append(sender)
                } else {
                    selectedButtons.removeAll()
                    selectedButtons.append(sender)
                }
            } else {
                selectedButtons.remove(at: selectedButtons.index(of: sender)!)
            }
            updateViewFromModel()
            
        } else {
            print ("cardButtonTouched: selected card not in card buttons collection")
            //dose nothing
        }
        
    }
    
    @IBAction func newGameTouched(_ sender: UIButton) {
        set = SetGame()
        selectedButtons.removeAll()
        hintedButons.removeAll()
        updateViewFromModel()
    }
    
    @IBAction func dealCardButtonTouched(_ sender: UIButton) {
        set.dealThreeMore()
        updateViewFromModel()
    }
    
    @IBAction func hintButtonTouched(_ sender: UIButton) {
        hintedButons.removeAll()
        set.provideHint()
        if  !set.hintCards.isEmpty {
            for index in 0..<3 {
                hintedButons += [cardButtons[set.cardsOnTable.index(of: set.hintCards[index])!]]
            }
        }
        
        updateHint()
    }
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        cardButtons.forEach { (button) in
            button.backgroundColor = UIColor.clear
        }
        updateViewFromModel()
        for index in cardButtons.indices {
            cardButtons[index].layer.cornerRadius = 8.0
            if index < set.cardsOnTable.count{
                cardButtons[index].setAttributedTitle(setCardTitle(for: set.cardsOnTable[index]), for: .normal)
            } else {
                cardButtons[index].setTitle("", for: .normal)
            }
        }
    }
        
    
    //methods
    
    
    func updateHint() {
        for index in cardButtons.indices {
            if hintedButons.contains(cardButtons[index]){
                cardButtons[index].layer.borderColor = UIColor.red.cgColor
            } else {
                cardButtons[index].layer.borderColor = UIColor.blue.cgColor
            }
        }
    }
    
    func updateViewFromModel() {

        
        scoreLabel.text = "Game Score: \(set.score)"
            // selection
        for index in cardButtons.indices{
            if index < set.cardsOnTable.count {
                let cardAttributedTitle = setCardTitle(for: set.cardsOnTable[index])
                if !matchedButtons.contains(cardButtons[index]) {
                    cardButtons[index].setAttributedTitle(cardAttributedTitle, for: .normal)
                    if selectedButtons.contains(cardButtons[index]) {
                        cardButtons[index].layer.borderWidth = 3.0
                        cardButtons[index].layer.borderColor = UIColor.red.cgColor
                    } else {
                        cardButtons[index].layer.borderWidth = 3.0
                        cardButtons[index].layer.borderColor = UIColor.blue.cgColor
                    }
                } else {
                    cardButtons[index].layer.borderWidth = 0.0
                    cardButtons[index].layer.borderColor = UIColor.clear.cgColor
                    cardButtons[index].setAttributedTitle(NSAttributedString(string: ""), for: .normal)
                }
            } else {
                cardButtons[index].layer.borderWidth = 0.0
                cardButtons[index].layer.borderColor = UIColor.clear.cgColor
                cardButtons[index].setAttributedTitle(NSAttributedString(string: ""), for: .normal)
            }
            
            
            
            
            
            
//            if !selectedButtons.contains(cardButtons[index]){ //buttons that are not selected
//                if !matchedButtons.contains(cardButtons[index]) { // buttons that are not matched
//                    cardButtons[index].layer.borderWidth = 3.0
//                    cardButtons[index].layer.borderColor = UIColor.blue.cgColor
//                } else { // buttons that are matched but not selected
//                    cardButtons[index].layer.borderWidth = 0.0
//                    cardButtons[index].layer.borderColor = UIColor.clear.cgColor
//                    cardButtons[index].setTitle("", for: .normal)
//                }
//
//            } else { // buttons that are selected
//                cardButtons[index].layer.borderWidth = 3.0
//                cardButtons[index].layer.borderColor = UIColor.red.cgColor
//            }
        }
    }
    
    private func setCardTitle(for card:Card) -> NSAttributedString {
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeColor: modelToView.colors[card.color]!,
            .foregroundColor: modelToView.colors[card.color]!.withAlphaComponent(modelToView.alpha[card.shading]!),
            .strokeWidth: modelToView.strokeWidth[card.shading]!,
        ]
        var title = card.symbol.rawValue
        switch card.number {
        case .two:
            title =
            "\(title)\(title)"
        case .three:
            title =
            "\(title)\(title)\(title)"
        default:
            break
        }
        
        return NSAttributedString(string: title, attributes: attributes)
    }
}

struct modelToView {
    static let shapes: [Card.Symbol: String] = [.circle: "●", .triangle: "▲", .square: "■"]
    static var colors: [Card.Color: UIColor] = [.red: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), .black: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), .blue: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)]
    static var alpha: [Card.Shading: CGFloat] = [.open: 0.4, .solid: 1.0, .striped: 0.15]
    static var strokeWidth: [Card.Shading: CGFloat] = [.open: 5, .solid: -5, .striped: -5]
}
