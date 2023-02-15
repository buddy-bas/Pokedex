//
//  HomeView.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 31/1/2566 BE.
//

import SwiftUI

struct Re: Identifiable {
    let id = UUID()
    let name: String
}

struct HomeView: View {
    @EnvironmentObject private var pokemonListState: PokemonListState
    @EnvironmentObject private var favoritesState: FavoritesState

    let services = Services()

    var body: some View {
        let _ = Self._printChanges()
        let pokemonList = pokemonListState.pokemonList.results
        List(Array(pokemonList.enumerated()), id: \.element.url) { index, item in
            ListViewItem(name: item.name.capitalized, detailUrl: item.url, pokemonId: index + 1, isSet: Binding(
                get: { self.pokemonListState.pokemonList.results[index].isFavorite ?? false },
                set: {
                    self.pokemonListState.pokemonList.results[index].isFavorite = $0
                    if $0 {
                        self.pokemonListState.pokemonList.results[index].favoritedDate = Date()
                    }
                }
            ))
            .background(NavigationLink("", destination: DetailView(url: item.url))
                .opacity(0))
            .task {
                if index == pokemonListState.pokemonList.results.count - 2 {
                    await loadMore()
                }
            }
        }
    }

    private func onPressFavorite(value: Bool, index: Int) {
        let data = pokemonListState.pokemonList.results[index]
        if value {
            favoritesState.favorites.append(PokemonListItem(name: data.name, url: data.url, pokemonId: index + 1))
        } else {
            let removeIndex = favoritesState.favorites.firstIndex { item in
                item.url == data.url
            }!
            favoritesState.favorites.remove(at: removeIndex)
        }
    }

    private func loadMore() async {
        do {
            let nextData = try await services.pokemonService.getPokemonList(url: pokemonListState.pokemonList.next)
            pokemonListState.pokemonList.results += nextData.results
            pokemonListState.pokemonList.next = nextData.next
        } catch {
            print(error)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var model = Model()
    static var previews: some View {
        HomeView()
            .environmentObject(model)
            .environmentObject(model.pokemonState)
            .environmentObject(model.pokemonListState)
    }
}
