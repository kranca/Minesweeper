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
        ZStack {
            Color(uiColor: DrawingConstants.background)
                .ignoresSafeArea()
            VStack {
                Text(viewModel.firstLocationOpen ? "Bombs left: \(viewModel.bombs - viewModel.flags)" : "Dig first hole to start game")
                    .foregroundColor(Color(uiColor: DrawingConstants.text))
                    .bold()
                let columns: [GridItem] = Array(repeating: .init(.fixed(25)), count: viewModel.width)
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.locations, id: \.self) { location in
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(location.isOpen ? Color(uiColor: DrawingConstants.openLocation) : Color(uiColor: DrawingConstants.untouchedLocation))
                            Text(viewModel.board[location]!)
                                .foregroundColor(Color(uiColor: DrawingConstants.text))
                                .opacity(location.isOpen ? 1 : 0)
                            Text("🚩")
                                .opacity(location.hasFlag ? 1 : 0)
                        }
                        .frame(minWidth: 25, minHeight: 25)
                        .onTapGesture {
                            viewModel.open(location)
                        }
                        .onLongPressGesture {
                            viewModel.placeFlag(on: location)
                        }
                    }
                }
            }
        }
    }
    
    private struct DrawingConstants {
        static let background = UIColor(red: 0.99, green: 0.98, blue: 0.94, alpha: 1.00)
        static let untouchedLocation = UIColor(red: 0.28, green: 0.50, blue: 0.39, alpha: 1.00)
        static let openLocation = UIColor(red: 0.94, green: 0.72, blue: 0.42, alpha: 1.00)
        static let text = UIColor(red: 0.10, green: 0.18, blue: 0.22, alpha: 1.00)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MinesweeperGame()
        ContentView(viewModel: game)
    }
}
