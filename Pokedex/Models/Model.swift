//
//  Model.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 17/1/2566 BE.
//

import Foundation

class Model: ObservableObject {
    var services: Services
    @Published var pokemon: Pokemon?
    @Published var pokemonList: PokemonList?

    init(services: Services = Services(pokemonService: PokemonService())) {
        self.services = services
    }
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
        pokemon = Pokemon(detail: detail, evolution: [])

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
                let evoDetail = try await services.pokemonService.getPokemonDetail(from:"https://pokeapi.co/api/v2/pokemon/\(result.id)")
                evoArr.append(Evolution(id: evoDetail.id, name: evoDetail.name, spriteUrl: evoDetail.sprites.frontDefault ?? ""))
            }
            return evoArr.sorted { $0.id < $1.id }
        }
        pokemon?.evolution = evolution
    }
    
    @MainActor
    func loadPokemonList(url:String) async throws {
        // get pokemon list
        let pokemonList = try await services.pokemonService.getPokemonList(url: url)
        self.pokemonList = pokemonList
    }
}
