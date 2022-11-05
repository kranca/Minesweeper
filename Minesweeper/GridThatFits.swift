//
//  GridThatFits.swift
//  Minesweeper
//
//  Created by Raúl Carrancá on 19/10/22.
//

import SwiftUI

struct GridThatFits<Item, ItemView>: View where ItemView: View, Item: Hashable {
    var items: [Item]
    var columnsCount: Int
    var rowCount: Int
    var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // 10 points padding between items
                let columnsWidth = min(
                    (geometry.size.width - 10 * CGFloat(columnsCount + 1)) / CGFloat(columnsCount),
                    (geometry.size.height - 10 * CGFloat(rowCount + 1)) / CGFloat(rowCount)
                )
                
                let columns: [GridItem] = Array(repeating: .init(.fixed(columnsWidth)), count: columnsCount)
                LazyVGrid(columns: columns) {
                    ForEach(items, id: \.self) { item in
                        content(item).frame(minWidth: columnsWidth, minHeight: columnsWidth)
                    }
                }
            }
        }
    }
}



//struct GridThatFits_Previews: PreviewProvider {
//    static var previews: some View {
//        GridThatFits()
//    }
//}
