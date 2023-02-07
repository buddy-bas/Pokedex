//
//  HomeView.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 31/1/2566 BE.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: Model

    var body: some View {
        NavigationView {
            if let pokemonList = model.pokemonList?.results {
                List(Array(pokemonList.enumerated()), id: \.offset) { index, item in
                    ListViewItem(name: item.name, detailUrl: item.url, pokemonId: index + 1)
                        .buttonStyle(.bordered)
                        .background(NavigationLink("", destination: DetailView(url: item.url))
                            .opacity(0))
                        .task {
                            if index == model.pokemonList!.results.count - 2 {
                                await loadMore()
                            }
                        }
                }
            }
        }
        .task {
            do {
                try await model.loadPokemonList(url: "https://pokeapi.co/api/v2/pokemon?limit=30&offset=0")

            } catch {
                print(error)
            }
        }
    }

    private func loadMore() async {
        do {
            let nextData = try await model.services.pokemonService.getPokemonList(url: model.pokemonList!.next)
            model.pokemonList!.results += nextData.results
            model.pokemonList!.next = nextData.next
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
