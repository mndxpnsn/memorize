//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Derek Harrison on 18/11/2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
