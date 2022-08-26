//
//  GameViewModel.swift
//  Minesweeper
//
//  Created by Raúl Carrancá on 25/08/22.
//

import SwiftUI

class MinesweeperGame: ObservableObject {
    private static func createMinesweeperGame() -> Game {
        return Game(width: 8, height: 12)
    }
    
    @Published private var model: Game
    
    init() {
        self.model = MinesweeperGame.createMinesweeperGame()
        
    }
    
    var board: [Location : String] {
        model.getBoard
    }
    
    var width: Int {
        model.getWidth
    }
    
    var height: Int {
        model.getHeight
    }
}
