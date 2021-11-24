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
        VStack {
            theme_title()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards, content: { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    })
                }
            }
            .foregroundColor(.red)
            .padding(.horizontal)

            Button(action: myAction, label: myLabel)
        }
    }
    
    func theme_title() -> Text {
        let theme = viewModel.get_theme()
        let prefix = "Theme: "
        let suffix = String(theme)
        return Text(prefix + suffix)
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
                shape.stroke(lineWidth: 3)
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
