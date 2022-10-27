//
//  GameViewModel.swift
//  Minesweeper
//
//  Created by Raúl Carrancá on 25/08/22.
//

import SwiftUI

class MinesweeperGame: ObservableObject {
    private static let imageContent = [
        0 : nil,
        1 : Image(systemName: "1.circle.fill"),
        2 : Image(systemName: "2.circle.fill"),
        3 : Image(systemName: "3.circle.fill"),
        4 : Image(systemName: "4.circle.fill"),
        5 : Image(systemName: "5.circle.fill"),
        6 : Image(systemName: "6.circle.fill"),
        7 : Image(systemName: "7.circle.fill"),
        8 : Image(systemName: "6.circle.fill"),
        nil: Image(systemName: "exclamationmark.triangle") //"exclamationmark.octagon.fill" "sun.min" "rays"
    ]
    private static func createMinesweeperGame() -> Game<Image?> {
        return Game(width: 8, height: 12, content: imageContent)
    }
    
    @Published private var model: Game<Image?>
    
    init() {
        self.model = MinesweeperGame.createMinesweeperGame()
    }
    
    let flag = "🚩"
    
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
    
    var gameHasStarted: Bool {
        model.gameHasStarted
    }
    
    var gameHasEnded: Bool {
        model.gameHasEnded
    }
    
    var didWin: Bool {
        model.didWin
    }
    
    func getValue(for location: Location) -> Image? {
        model.getValue(for: location) ?? nil
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
    
    func startNewGame(width: Int, height: Int) {
        model = Game(width: width, height: height, content: MinesweeperGame.imageContent)
    }
    
    func restartGame() {
        model = Game(width: width, height: height, content: MinesweeperGame.imageContent)
    }
}
