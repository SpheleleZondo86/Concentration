//
//  Concentration.swift
//  Concentration
//
//  Created by Sphelele Zondo on 2018/07/03.
//  Copyright © 2018 Sphelele Zondo. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = Array<Card>()
    private var indexOfOneAndOnlyFaceUpCard:Int?{
        get{
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }set{
            for index in cards.indices{
                cards[index].isFaceUp = (index==newValue)
            }
        }
    }
    
    mutating func chooseCard(at index:Int){
        assert(cards.indices.contains(index),"Concentration.chooseCard(at:\(index)): wrong index")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched=true
                    cards[index].isMatched=true
                }
                cards[index].isFaceUp=true
            }
            else{
                indexOfOneAndOnlyFaceUpCard=index 
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards>0,"Concentration.init(at:\(numberOfPairsOfCards)): atleast one pair of cards")
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        //TODO: shuffle the cards
    }
}

extension Collection{
    var oneAndOnly: Element?{
        return count == 1 ? first : nil
    }
}
