//
//  ContentView.swift
//  Minesweeper
//
//  Created by Raúl Carrancá on 24/08/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MinesweeperGame
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0...viewModel.height - 1, id: \.self) { y in
                HStack {
                    ForEach(0...viewModel.width - 1, id: \.self) { x in
                        Text(viewModel.board[Location(x: x, y: y)]!)
                            .frame(minWidth: 25, minHeight: 25)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MinesweeperGame()
        ContentView(viewModel: game)
    }
}
