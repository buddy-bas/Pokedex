//
//  TabBarNavigation.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 31/1/2566 BE.
//

import SwiftUI

struct TabBarNavigation: View {
    @State private var selection: Int = 1
    @EnvironmentObject var model: Model
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                HomeView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Pokémon")
                           
                    }
                    .tag(1)
                FavoritesView()
                    .tabItem {
                        Image(systemName: "star")
                        Text("Favorite")
                    }
                    .tag(2)
            }
            .navigationBarTitle(selection == 1 ? "Pokémon" : "")
        }
        
        .task {
            do {
                print("call")
                try await model.loadPokemonList(url: "https://pokeapi.co/api/v2/pokemon?limit=30&offset=0")

            } catch {
                print(error)
            }
        }
    }
}

struct TabBarNavigation_Previews: PreviewProvider {
    static let model = Model()
    static var previews: some View {
        TabBarNavigation()
            .environmentObject(model)
            .environmentObject(model.tabViewState)
            .environmentObject(model.pokemonState)
            .environmentObject(model.pokemonListState)
            .environmentObject(model.favoritesState)
    }
}
