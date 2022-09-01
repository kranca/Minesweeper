//
//  Game.swift
//  Minesweeper
//
//  Created by Raúl Carrancá on 24/08/22.
//

import Foundation

struct Game {
    private let width: Int
    private let height: Int
    
    private var board: [Location : String]
    
    private var bombs = [Location]()
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.board = [Location: String]()
        
        // populate board with 0's
        for y in 0...(height - 1) {
            for x in 0...(width - 1) {
                board[Location(x: x, y: y)] = "0"
            }
        }
        
        // define random locations for the bombs
        for _ in 0...(width * height * 3 / 10)-1 {
            var bombLocation: Location
            repeat {
                bombLocation = Location(x: Int.random(in: 0...width-1), y: Int.random(in: 0...height-1))
            } while board[bombLocation] == "💣"
            
            board[bombLocation] = "💣"
            bombs.append(bombLocation)
        }
        
        // update locations adjacent to bombs to indicate how many bombs are directly adjacent to them
        for bomb in bombs {
            for location in neighbours(of: bomb) {
                if board[location] != "💣" {
                    if let noBomb = board[location] {
                        board[location] = String(Int(noBomb)! + 1)
                    }
                }
            }
        }
    }
    
    private func neighbours(of location: Location) -> [Location] {
        var neighbours = [Location]()
        // left-up
        if location.x > 0 && location.y > 0 {
            neighbours.append(Location(x: location.x - 1, y: location.y - 1))
        }
        // up
        if location.y > 0 {
            neighbours.append(Location(x: location.x, y: location.y - 1))
        }
        // right-up
        if location.x < width - 1 && location.y > 0 {
            neighbours.append(Location(x: location.x + 1, y: location.y - 1))
        }
        // left
        if location.x > 0 {
            neighbours.append(Location(x: location.x - 1, y: location.y))
        }
        // right
        if location.x < width - 1 {
            neighbours.append(Location(x: location.x + 1, y: location.y))
        }
        // left-down
        if location.x > 0 && location.y < height - 1 {
            neighbours.append(Location(x: location.x - 1, y: location.y + 1))
        }
        // down
        if location.y < height - 1 {
            neighbours.append(Location(x: location.x, y: location.y + 1))
        }
        // right-down
        if location.x < width - 1 && location.y < height - 1 {
            neighbours.append(Location(x: location.x + 1, y: location.y + 1))
        }
        
        return neighbours
    }
    
    var getWidth: Int {
        width
    }
    
    var getHeight: Int {
        height
    }
    
    var getBoard: [Location : String] {
        board
    }
    
    var getLocations: [Location] {
        board.keys.sorted(by: { $0 < $1 })
    }
    
    mutating func open(_ location: Location) {
        if !location.isOpen {
            if let chosenLocation = board.keys.firstIndex(where: { $0 == location }) {
                let locationValue = board[location]
                board.remove(at: chosenLocation)
                let updatedLocation = Location(x: location.x, y: location.y, isOpen: true)
                board[updatedLocation] = locationValue
                if locationValue == "0" {
                    let neighboringToOpen = neighbours(of: updatedLocation)
                    for neighbour in neighboringToOpen {
                        open(neighbour)
                    }
                }
            }
        }
    }
}

struct Location: Hashable, Comparable {
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
    
    var isOpen = false
}

