//
//  HomeView.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 31/1/2566 BE.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var pokemonListState: PokemonListState
    @EnvironmentObject var model: Model
    
    var body: some View {
        let _ = Self._printChanges()
        if let pokemonList = pokemonListState.pokemonList?.results {
            List(Array(pokemonList.enumerated()), id: \.element.url) { index, item in
                ListViewItem(name: item.name, detailUrl: item.url, pokemonId: index + 1)
                    .background(NavigationLink("", destination: DetailView(url: item.url))
                        .opacity(0))
                    .task {
                        if index == pokemonListState.pokemonList!.results.count - 2 {
                            await loadMore()
                        }
                    }
            }
        } else {
            Text("Empty")
        }
    }
    
    private func loadMore() async {
        do {
            let nextData = try await model.services.pokemonService.getPokemonList(url: pokemonListState.pokemonList!.next)
            pokemonListState.pokemonList!.results += nextData.results
            pokemonListState.pokemonList!.next = nextData.next
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
    }
}
