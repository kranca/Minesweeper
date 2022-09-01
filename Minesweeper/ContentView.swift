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
        VStack {
            let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 25)), count: viewModel.width)
            LazyVGrid(columns: columns) {
                ForEach(viewModel.locations, id: \.self) { location in
                    Text(viewModel.board[location]!)
                        .frame(minWidth: 25, minHeight: 25)
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
