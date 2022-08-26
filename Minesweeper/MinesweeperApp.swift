//
//  MinesweeperApp.swift
//  Minesweeper
//
//  Created by Raúl Carrancá on 24/08/22.
//

import SwiftUI

@main
struct MinesweeperApp: App {
    let game = MinesweeperGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
