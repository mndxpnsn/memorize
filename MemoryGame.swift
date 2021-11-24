//
//  MemoryGame.swift
//  Memorize
//  This is the model
//  Created by Derek Harrison on 20/11/2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private var numberOfCards: Int
    
    init(numberOfPairsOfCards: Int, cardsTheme: Int, createCardContent: (Int, Int) -> CardContent) {
        cards = Array<Card>()
        numberOfCards = 2 * numberOfPairsOfCards

        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(cardsTheme, pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = index(of: card),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            }
            else {
                for index in 0..<cards.count {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    func index(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    mutating func new_game(num_cards: Int, theme: Int, cardContent: (Int, Int) -> CardContent) {
        for index in 0..<num_cards {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].content = cardContent(theme,  Int(index) / 2)
        }
        indexOfTheOneAndOnlyFaceUpCard = nil
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
