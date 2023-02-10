//
//  FavoritesView.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 7/2/2566 BE.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var model: Model
    

    var body: some View {
        if model.favoritesState.favorites.count > 0 {
            List {
                ForEach(Array(model.favoritesState.favorites.enumerated()), id: \.offset) { index, item in
                    ListViewItem(name: item.name, detailUrl: item.url, pokemonId: item.pokemonId!, showFavoriteIcon: false)
                        .swipeActions(allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                model.favoritesState.favorites.remove(at: index)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
        } else {
            Text("empty")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var model = Model()
    static var previews: some View {
        FavoritesView()
            .environmentObject(model)
    }
}
