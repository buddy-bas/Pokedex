//
//  FavoritesView.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 7/2/2566 BE.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var pokemonListState: PokemonListState

    @State private var showAlert = false
    @State private var removeIndex = -1

    var favoritesPokemon: [PokemonListItem] {
        let filtered = pokemonListState.pokemonList.results.filter { PokemonListItem in
            PokemonListItem.isFavorite ?? false
        }
        let sorted = filtered.sorted { $0.favoritedDate! < $1.favoritedDate! }
        return sorted
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        let _ = Self._printChanges()
        ScrollView {
            Text("Favorite")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top,32)
                .frame(maxWidth: .infinity, alignment: .leading)
            LazyVGrid(columns: columns, spacing: 16
            ) {
                ForEach(favoritesPokemon, id: \.url) { item in
                    NavigationLink {
                        DetailView(url: item.url)
                    } label: {
                        FavoriteGridItem(detailUrl: item.url, name: item.name.capitalized)
                            .contextMenu {
                                Button(role: .destructive) {
                                    showAlert = true
                                    removeIndex = pokemonListState.pokemonList.results.firstIndex { PokemonListItem in
                                        PokemonListItem.url == item.url
                                    }!

                                } label: {
                                    Label("Unfavorite Pokémon", systemImage: "star.slash")
                                }
                            }
                            .transition(.move(edge: .trailing))
                    }
                    .buttonStyle(FlatLinkStyle())
                }
                .alert("", isPresented: $showAlert, actions: {
                    Button("Unfavorite", role: .destructive, action: {
                        withAnimation {
                            pokemonListState.pokemonList.results[removeIndex].isFavorite = false
                        }
                    })
                }, message: {
                    Text("Are you sure you want to unfavorite this Pokémon?")
                })
            }
            .padding(.horizontal)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var model = Model()
    static var previews: some View {
        FavoritesView()
            .environmentObject(model)
            .environmentObject(model.pokemonListState)
    }
}
