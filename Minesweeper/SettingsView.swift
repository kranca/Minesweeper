//
//  SettingsView.swift
//  Minesweeper
//
//  Created by Raúl Carrancá on 25/10/22.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: MinesweeperGame
    var body: some View {
        Form {
            Section(header: Text("Width")) {
                Stepper(String(viewModel.width),
                        onIncrement: { viewModel.availableSize.width / Double(viewModel.width) > viewModel.minimumWidth ? viewModel.startNewGame(width: viewModel.width + 1, height: viewModel.height) : nil },
                        onDecrement: { viewModel.width > 4 ? viewModel.startNewGame(width: viewModel.width - 1, height: viewModel.height) : nil })
            }
            Section(header: Text("Height")) {
                Stepper(String(viewModel.height),
                        onIncrement: { viewModel.availableSize.height / Double(viewModel.height) > viewModel.minimumWidth ? viewModel.startNewGame(width: viewModel.width, height: viewModel.height + 1) : nil },
                        onDecrement: { viewModel.height > 6 ? viewModel.startNewGame(width: viewModel.width, height: viewModel.height - 1) : nil })
            }
        }
        .frame(minWidth: 300.0, minHeight: 350.0)
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = MinesweeperGame()
        SettingsView(viewModel: game)
            .previewLayout(.fixed(width: 300.0, height: 350.0))
    }
}
