//
//  Game.swift
//  Minesweeper
//
//  Created by Raúl Carrancá on 24/08/22.
//

import Foundation
import SwiftUI

struct Game<Content> {
    private let width: Int
    private let height: Int
    
    private var board: [Location]
    
    private(set) var gameHasStarted = false
    private(set) var gameHasEnded = false
    
    let content: [Int? : Content?]
    
    private mutating func populateBoardWithZeros(width: Int, height: Int) {
        for y in 0..<height {
            for x in 0..<width {
                let location = Location(x: x, y: y, value: 0)
                board.append(location)
            }
        }
    }
    
    init(width: Int, height: Int, content: [Int? : Content?]) {
        self.width = width
        self.height = height
        self.board = [Location]()
        self.content = content
        
        populateBoardWithZeros(width: width, height: height)
    }
    
    init(using storedLocations: [Location], content: [Int? : Content?]) {
        self.board = storedLocations
        self.width = storedLocations.max(by: { $0.x < $1.x })!.x + 1
        self.height = storedLocations.max(by: { $0.y < $1.y })!.y + 1
        self.content = content
        if storedLocations.contains(where: { $0.isOpen }) {
            gameHasStarted = true
        }
        if storedLocations.contains(where: { $0.isOpen && $0.hasBomb || didWin }){
            gameHasStarted = false
            board = [Location]()
            populateBoardWithZeros(width: width, height: height)
        }
    }
    
    private func neighbours(of location: Location) -> [Location] {
        var neighbours = [Location]()
        // left-up
        if location.x > 0 && location.y > 0 {
            neighbours.append(board.first(where: { $0.x == location.x - 1 && $0.y == location.y - 1 })!)
        }
        // up
        if location.y > 0 {
            neighbours.append(board.first(where: { $0.x == location.x && $0.y == location.y - 1 })!)
        }
        // right-up
        if location.x < width - 1 && location.y > 0 {
            neighbours.append(board.first(where: { $0.x == location.x + 1 && $0.y == location.y - 1 })!)
        }
        // left
        if location.x > 0 {
            neighbours.append(board.first(where: { $0.x == location.x - 1 && $0.y == location.y })!)
        }
        // right
        if location.x < width - 1 {
            neighbours.append(board.first(where: { $0.x == location.x + 1 && $0.y == location.y })!)
        }
        // left-down
        if location.x > 0 && location.y < height - 1 {
            neighbours.append(board.first(where: { $0.x == location.x - 1 && $0.y == location.y + 1 })!)
        }
        // down
        if location.y < height - 1 {
            neighbours.append(board.first(where: { $0.x == location.x && $0.y == location.y + 1 })!)
        }
        // right-down
        if location.x < width - 1 && location.y < height - 1 {
            neighbours.append(board.first(where: { $0.x == location.x + 1 && $0.y == location.y + 1 })!)
        }
        
        return neighbours
    }
    
    var getWidth: Int {
        width
    }
    
    var getHeight: Int {
        height
    }
    
    var getLocations: [Location] {
        board//.sorted(by: { $0 < $1 })
    }
    
    private var bombs: [Location] {
        board.filter( { $0.hasBomb })
    }
    
    var bombsCount: Int {
        bombs.count
    }
    
    var flagsCount: Int {
        var flags = 0
        for location in board {
            if location.hasFlag {
                flags += 1
            }
        }
        return flags
    }
    
    var didWin: Bool {
        // all bombs on board have a flag and flag count == bombs count
        bombs.filter { !$0.hasFlag }.isEmpty && board.filter { $0.hasFlag }.count == bombsCount
        // or all locations without a bomb have been opend
        || board.filter { !$0.hasBomb }.filter { $0.isOpen }.count == width * height - bombsCount
    }
    
    func getValue(for location: Location) -> Content? {
        content[location.value] ?? nil
    }
    
    
    mutating func openFirst(_ location: Location) {
        // define random locations for the bombs and avoid more than one bomb in the same location or a bomb on first opened location or direct neighbours
        for _ in 0...(width * height * 2 / 10)-1 {
            var bombLocation: Location
            repeat {
                bombLocation = board.randomElement()!
            } while bombLocation == location || neighbours(of: location).contains(bombLocation) || bombLocation.hasBomb
            
            board.updateLocation(location: bombLocation, newValue: nil, hasBomb: true, isOpen: false, hasFlag: false)
        }
        
        // update locations adjacent to bombs to indicate how many bombs are directly adjacent to them
        for bomb in bombs {
            for location in neighbours(of: bomb) {
                if !location.hasBomb {
                    board.updateLocation(location: location, newValue: location.value! + 1, hasBomb: false, isOpen: false, hasFlag: false)
                }
            }
        }
        // open first location
        open(location)
        gameHasStarted = true
    }
    
    mutating func open(_ location: Location) {
        if !location.isOpen && !location.hasFlag && !gameHasEnded {
            board.updateLocation(location: location, newValue: location.value, hasBomb: location.hasBomb, isOpen: true, hasFlag: location.hasFlag)
            if location.value == 0 {
                let neighboringToOpen = neighbours(of: location)
                for neighbour in neighboringToOpen {
                    open(neighbour)
                }
            }
            if location.hasBomb {
                showAllBombs()
                gameHasEnded = true
            }
            if didWin {
                gameHasEnded = true
            }
        }
    }
    
    private mutating func showAllBombs() {
        for location in bombs {
            board.updateLocation(location: location, newValue: location.value, hasBomb: location.hasBomb, isOpen: true, hasFlag: location.hasFlag)
        }
    }
    
    mutating func placeFlag(on location: Location) {
        if !location.isOpen && gameHasStarted && !gameHasEnded {
            board.updateLocation(location: location, newValue: location.value, hasBomb: location.hasBomb, isOpen: location.isOpen, hasFlag: !location.hasFlag)
            
            if didWin {
                gameHasEnded = true
            }
        }
    }
}

struct Location: Hashable, Comparable, Codable {
    static func < (lhs: Location, rhs: Location) -> Bool {
        if lhs.y < rhs.y {
            return true
        } else if lhs.y == rhs.y {
            if lhs.x < rhs.x {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    let x: Int
    let y: Int
    var value: Int?
    
    var hasBomb = false
    var isOpen = false
    var hasFlag = false
}

extension Array where Element == Location {
    mutating func updateLocation(location: Location, newValue: Int?, hasBomb: Bool, isOpen: Bool, hasFlag: Bool) {
        if let chosenLocation = self.firstIndex(where: { $0.x == location.x && $0.y == location.y }) {
            self[chosenLocation].value = newValue
            self[chosenLocation].hasBomb = hasBomb
            self[chosenLocation].isOpen = isOpen
            self[chosenLocation].hasFlag = hasFlag
        }
    }
}

