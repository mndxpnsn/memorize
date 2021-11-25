//
//  ContentView.swift
//  Memorize
//
//  Created by Derek Harrison on 18/11/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        let color = get_theme_color()
        VStack {
            theme_title()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(viewModel.cards, content: { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    })
                }
            }
            .foregroundColor(color)
            .padding(.horizontal)

            HStack {
                Button(action: myAction, label: myLabel)
                Spacer()
                game_score()
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
    }
    
    func theme_title() -> Text {
        let theme = viewModel.get_theme() + 1
        let prefix = "Theme: "
        let suffix = String(theme)
        return Text(prefix + suffix)
    }
    
    func game_score() -> Text {
        let score = viewModel.get_score()
        let prefix = "Score: "
        let suffix = String(score)
        return Text(prefix + suffix)
    }
    
    func get_theme_color() -> Color {
        return viewModel.get_theme_color()
    }
    
    func myAction () -> Void {
        viewModel.new_game()
    }
    
    func myLabel () -> Text {
        return Text("New Game")
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            }
            else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill()
                shape.strokeBorder(lineWidth: 3)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        Group {
            ContentView(viewModel: game)
                .preferredColorScheme(.light)
                .previewInterfaceOrientation(.portrait)
        }
    }
}
