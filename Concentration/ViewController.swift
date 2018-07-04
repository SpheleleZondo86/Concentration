//
//  ViewController.swift
//  Concentration
//
//  Created by Sphelele Zondo on 2018/07/02.
//  Copyright © 2018 Sphelele Zondo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards:Int{
            return (cardButtons.count+1) / 2
    }

    private(set) var flipCount = 0{
        didSet{
           updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes : Dictionary<NSAttributedStringKey,Any> = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        FlipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBOutlet private weak var FlipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            print("card number: \(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("card not in the array!")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor=#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    //private var emojis = ["👽","🎃","👻","💀","🤡","👣","👣","🎃","👽"]
    private var emojis = "👽🎃👻💀🤡👣👣🎃👽"

    private var emoji = Dictionary<Card,String>()
    
    private func emoji (for card:Card)->String{
        if emoji[card]==nil,emojis.count>0{
            let randomStringIndex = emojis.index(emojis.startIndex, offsetBy: emojis.count.arc4random)
            emoji[card] = String(emojis.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self<0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0;
        }
    }
}

