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
var theme_colors: Array<Color> = Array<Color>()
var theme: Int = 0

class EmojiMemoryGame: ObservableObject {
    
    static let emojis_theme1 = ["🚂", "🚀", "🚁", "🚜"]
    static let emojis_theme2 = ["🚗", "🚄", "🛵", "🚅"]
    static let emojis_theme3 = ["🏎", "🚍", "🗿", "🕍"]
    static let emojis_theme4 = ["📡", "💿", "⛓", "🧲"]
    static let emojis_theme5 = ["🛠", "⚙️", "🔫", "🗡"]
    static let emojis_theme6 = ["🏅", "🥜", "🥠", "🎂"]
    static var init_set = false
    
    static func add_theme(emojis: Array<String>, color: Color) {
        emoji_themes.append(emojis)
        theme_colors.append(color)
    }
    
    static func set_emoji_themes() {
        add_theme(emojis: emojis_theme1, color: Color.red)
        add_theme(emojis: emojis_theme2, color: Color.blue)
        add_theme(emojis: emojis_theme3, color: Color.green)
        add_theme(emojis: emojis_theme4, color: Color.orange)
        add_theme(emojis: emojis_theme5, color: Color.yellow)
        add_theme(emojis: emojis_theme6, color: Color.brown)
        let theme_count = emoji_themes.count
        theme = Int.random(in: 0..<theme_count)
    }
    
    static func create_card_content (index: Int) -> String {
        return emoji_themes[theme][index]
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        if EmojiMemoryGame.init_set == false {
            set_emoji_themes()
            EmojiMemoryGame.init_set = true
        }
        
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCardsGlb, createCardContent: create_card_content)
    }
    
    init() {
        if EmojiMemoryGame.init_set == false {
            EmojiMemoryGame.set_emoji_themes()
            EmojiMemoryGame.init_set = true
        }
    }
    
    @Published private(set) var model: MemoryGame<String> = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func new_game() {
        let theme_count = emoji_themes.count
        theme = Int.random(in: 0..<theme_count)
        model.new_game(num_cards: numberOfPairsOfCardsGlb * 2, cardContent: { index in
            return emoji_themes[theme][index]
        })
    }
    
    func get_theme() -> Int {
        return theme
    }
    
    func get_theme_color() -> Color {
        return theme_colors[theme]
    }
}
