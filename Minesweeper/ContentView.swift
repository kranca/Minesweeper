//
//  ContentView.swift
//  Minesweeper
//
//  Created by Raúl Carrancá on 24/08/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MinesweeperGame
    @State var editing = false
    
    var body: some View {
        ZStack {
            Color(uiColor: DrawingConstants.background)
                .ignoresSafeArea()
            VStack {
                header
                boardView
                bottomView
            }
        }
    }
    
    var header: some View {
        Text(viewModel.firstLocationOpen ? "Bombs left: \(viewModel.bombs - viewModel.flags)" : "Dig first hole to start game")
            .foregroundColor(Color(uiColor: DrawingConstants.text))
            .font(.title)
            .bold()
    }
    
    var boardView: some View {
        GridThatFits(items: viewModel.locations, columnsCount: viewModel.width, rowCount: viewModel.height) { location in
            GeometryReader { geometry in
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(location.isOpen ? Color(uiColor: DrawingConstants.openLocation) : Color(uiColor: DrawingConstants.untouchedLocation))
                    viewModel.getValue(for: location)?
                        .foregroundColor(Color(uiColor: DrawingConstants.text))
                        .opacity(location.isOpen ? 1 : 0)
                    Text(viewModel.flag)
                        .opacity(location.hasFlag ? 1 : 0)
                }
                .font(.system(size: geometry.size.width * 0.8))
                .onTapGesture {
                    viewModel.open(location)
                }
                .onLongPressGesture {
                    viewModel.placeFlag(on: location)
                }
            }
        }
    }
    
    var bottomView: some View {
        HStack {
            Button(action: {
                editing = true
            }, label: {
                Image(systemName: "slider.horizontal.3")
            })
            .popover(isPresented: $editing) {
                SettingsView(viewModel: viewModel)
            }
            Spacer()
            didWin()
            Spacer()
            Button(action: {
                viewModel.restartGame()
            }, label: {
                Image(systemName: "restart")
            })
        }
        .padding(.horizontal)
        .font(.title)
    }
    
    @ViewBuilder
    private func didWin() -> some View {
        if viewModel.gameHasEnded {
            if viewModel.didWin {
                Text("You won!! 🎉")
            } else {
                Text("You lost 😩")
            }
        } else if viewModel.gameHasStarted {
            Text("Keep on diging...")
        } else {
            Text(" ")
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
