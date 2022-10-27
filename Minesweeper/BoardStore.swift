//
//  BoardStore.swift
//  Minesweeper
//
//  Created by Raúl Carrancá on 26/10/22.
//

import SwiftUI

struct Board {
    let name: String
    let width: Int
    let height: Int
    let flag: String
    let content: [Int? : Image?]
    let id: Int
    
    fileprivate init(name: String, width: Int, height: Int, flag: String, content: [Int? : Image?], id: Int) {
        self.name = name
        self.width = width
        self.height = height
        self.flag = flag
        self.content = content
        self.id = id
    }
}

class BoardStore: ObservableObject {
    let name: String
    
    @Published var boards = [Board]()
    
    init(name: String) {
        self.name = name
        
        if boards.isEmpty {
            insertBoard(named: "Easy",
                        width: 6,
                        height: 10,
                        flag: "🏳️",
                        content: [
                            0 : nil,
                            1 : Image(systemName: "1.circle"),
                            2 : Image(systemName: "2.circle"),
                            3 : Image(systemName: "3.circle"),
                            4 : Image(systemName: "4.circle"),
                            5 : Image(systemName: "5.circle"),
                            6 : Image(systemName: "6.circle"),
                            7 : Image(systemName: "7.circle"),
                            8 : Image(systemName: "6.circle"),
                            nil: Image(systemName: "exclamationmark.triangle")
                        ]
            )
            insertBoard(named: "Intermediate",
                        width: 8,
                        height: 12,
                        flag: "🚩",
                        content: [
                            0 : nil,
                            1 : Image(systemName: "1.circle.fill"),
                            2 : Image(systemName: "2.circle.fill"),
                            3 : Image(systemName: "3.circle.fill"),
                            4 : Image(systemName: "4.circle.fill"),
                            5 : Image(systemName: "5.circle.fill"),
                            6 : Image(systemName: "6.circle.fill"),
                            7 : Image(systemName: "7.circle.fill"),
                            8 : Image(systemName: "6.circle.fill"),
                            nil: Image(systemName: "exclamationmark.triangle")
                        ]
            )
            insertBoard(named: "Expert",
                        width: 10,
                        height: 14,
                        flag: "🏴",
                        content: [
                            0 : nil,
                            1 : Image(systemName: "1.circle.fill"),
                            2 : Image(systemName: "2.circle.fill"),
                            3 : Image(systemName: "3.circle.fill"),
                            4 : Image(systemName: "4.circle.fill"),
                            5 : Image(systemName: "5.circle.fill"),
                            6 : Image(systemName: "6.circle.fill"),
                            7 : Image(systemName: "7.circle.fill"),
                            8 : Image(systemName: "6.circle.fill"),
                            nil: Image(systemName: "exclamationmark.triangle")
                        ]
            )
        }
    }
    
    func insertBoard(named name: String, width: Int, height: Int, flag: String, content: [Int? : Image?]) {
        let uniqueId = (boards.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let newBoard = Board(name: name, width: width, height: height, flag: flag, content: content, id: uniqueId)
        boards.append(newBoard)
    }
    
    func board(at index: Int) -> Board {
        let safeIndex = min(max(index, 0), boards.count - 1)
        return boards[safeIndex]
    }
}
