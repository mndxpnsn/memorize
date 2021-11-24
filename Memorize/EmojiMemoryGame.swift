//
//  EmojiMemoryGame.swift
//  Memorize
//  This is the view model
//  Created by Derek Harrison on 20/11/2021.
//

//import Foundation
import SwiftUI

let numberOfPairsOfCardsGlb = 4
var emoji_themes: [[String]] = [[String]]()
var theme: Int = 0

class EmojiMemoryGame: ObservableObject {
    
    static let emojis_theme1 = ["🚂", "🚀", "🚁", "🚜"]
    static let emojis_theme2 = ["🚗", "🚄", "🛵", "🚅"]
    static let emojis_theme3 = ["🏎", "🚍", "🗿", "🕍"]
    static let emojis_theme4 = ["📡", "💿", "⛓", "🧲"]
    static let emojis_theme5 = ["🛠", "⚙️", "🔫", "🗡"]
    static let emojis_theme6 = ["🏅", "🥜", "🥠", "🎂"]
    static var init_set = false
    
    init() {
        if EmojiMemoryGame.init_set == false {
            EmojiMemoryGame.set_emoji_themes()
            EmojiMemoryGame.init_set = true
        }
    }
    
    static func set_emoji_themes() {
        emoji_themes.append(EmojiMemoryGame.emojis_theme1)
        emoji_themes.append(EmojiMemoryGame.emojis_theme2)
        emoji_themes.append(EmojiMemoryGame.emojis_theme3)
        emoji_themes.append(EmojiMemoryGame.emojis_theme4)
        emoji_themes.append(EmojiMemoryGame.emojis_theme5)
        emoji_themes.append(EmojiMemoryGame.emojis_theme6)
        let theme_count = emoji_themes.count
        print("theme init: ")
        print(theme_count)
        theme = Int.random(in: 0..<theme_count)
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        if EmojiMemoryGame.init_set == false {
            set_emoji_themes()
            EmojiMemoryGame.init_set = true
        }
        
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCardsGlb, cardsTheme: theme, createCardContent: create_card_content)
    }
    
    @Published private(set) var model: MemoryGame<String> = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }

    static func create_card_content (theme: Int, index: Int) -> String {
        return emoji_themes[theme][index]
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func new_game() {
        let theme_count = emoji_themes.count
        theme = Int.random(in: 0..<theme_count)
        print("theme: ")
        print(theme)
        model.new_game(num_cards: numberOfPairsOfCardsGlb * 2, theme: theme, cardContent: { theme, index in
            return emoji_themes[theme][index]
        })
    }
    
    func get_theme() -> Int {
        return theme
    }
}
