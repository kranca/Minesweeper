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
            let columns: [GridItem] = Array(repeating: .init(.fixed(25)), count: viewModel.width)
            LazyVGrid(columns: columns) {
                ForEach(viewModel.locations, id: \.self) { location in
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(location.isOpen ? .brown : .black)
                        Text(viewModel.board[location]!)
                            .opacity(location.isOpen ? 1 : 0)
                    }
                    .frame(minWidth: 25, minHeight: 25)
                    .onTapGesture {
                        viewModel.open(location)
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
