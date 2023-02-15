//
//  Model.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 17/1/2566 BE.
//

import Foundation

class Model: ObservableObject {
    var services = Services()
    var tabViewState = TabViewState()
    var pokemonState = PokemonState()
    var pokemonListState = PokemonListState()
    var favoritesState = FavoritesState()
}

// MARK: - Pokemon API

extension Model {
    private struct EvolutionChain: Codable {
        let evolution_chain: Chain
        struct Chain: Codable {
            let url: String
        }
    }

    func makeFlatEvolvesArr(_ chain: [Chain]) -> [Species] {
        var arr: [Species] = []
        chain.forEach { item in
            arr.append(item.species)
            arr += makeFlatEvolvesArr(item.evolvesTo)
        }
        return arr
    }

    @MainActor
    func loadPokemon(from url: String) async throws {
        // get pokemon detail
        let detail = try await services.pokemonService.getPokemonDetail(from: url)
        pokemonState.pokemon = Pokemon(detail: detail, evolution: [])

        // get pokemon evolution
        let species = try await services.pokemonService.getSpecies(from: detail.species.url)
        let rawEvolutions = try await services.pokemonService.getRawEvolution(from: species.evolutionChain?.url ?? "")
        var flatEvolution = makeFlatEvolvesArr(rawEvolutions.chain.evolvesTo)
        flatEvolution.insert(rawEvolutions.chain.species, at: 0)

        let evolution = try await withThrowingTaskGroup(of: SpeciesRawResponse.self) { group in
            for item in flatEvolution {
                group.addTask { try await self.services.pokemonService.getSpecies(from: item.url) }
            }
            var evoArr = [Evolution]()
            for try await result in group {
                let evoDetail = try await services.pokemonService.getPokemonDetail(from: "https://pokeapi.co/api/v2/pokemon/\(result.id)")
                evoArr.append(Evolution(id: evoDetail.id, name: evoDetail.name, spriteUrl: evoDetail.sprites.frontDefault ?? ""))
            }
            return evoArr.sorted { $0.id < $1.id }
        }
        pokemonState.pokemon?.evolution = evolution
    }

    @MainActor
    func loadPokemonList(url: String) async throws {
        // get pokemon list
        let pokemonList = try await services.pokemonService.getPokemonList(url: url)
        pokemonListState.pokemonList = pokemonList
    }
}

// MARK: - Manage favorites

extension Model {
}

enum Tabs {
    case home
    case fav
}

class TabViewState: ObservableObject {
    @Published var selectedTab: Tabs = .home
}

class PokemonState: ObservableObject {
    @Published var pokemon: Pokemon?
}

class PokemonListState: ObservableObject {
    @Published var pokemonList: PokemonList = PokemonList(count: 0, results: [], next: "")
}

class FavoritesState: ObservableObject {
    @Published var favorites: [PokemonListItem] = []
}
