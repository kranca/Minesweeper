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
    
    var board: [Location] {
        model.getBoard
    }
    
    var width: Int {
        model.getWidth
    }
    
    var height: Int {
        model.getHeight
    }
    
    var locations: [Location] {
        model.getLocations
    }
    var bombs: Int {
        model.bombsCount
    }
    
    var flags: Int {
        model.flagsCount
    }
    
    var firstLocationOpen: Bool {
        model.gameHasStarted
    }
    
    var gameHasEnded: Bool {
        model.gameHasEnded
    }
    
    func getValue(for location: Location) -> Image? {
        if location.value == 1 {
            return Image(systemName: "1.circle")
        } else if location.value == 2 {
            return Image(systemName: "2.circle")
        } else if location.value == 3 {
            return Image(systemName: "3.circle")
        } else if location.value == 4 {
            return Image(systemName: "4.circle")
        } else if location.value == 5 {
            return Image(systemName: "5.circle")
        } else if location.value == 6 {
            return Image(systemName: "6.circle")
        } else if location.value == 7 {
            return Image(systemName: "7.circle.fill")
        } else if location.value == 0 {
            return nil
        } else {
            return Image(systemName: "exclamationmark.octagon.fill")
        }
    }

    
    // MARK: - Intents
    func open(_ location: Location) {
        if !model.gameHasStarted {
            model.openFirst(location)
        } else {
            model.open(location)
        }
    }
    
    func placeFlag(on location: Location) {
        model.placeFlag(on: location)
    }
}
