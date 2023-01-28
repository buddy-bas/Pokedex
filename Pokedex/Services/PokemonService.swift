//
//  PokemonService.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 27/1/2566 BE.
//

import Foundation


protocol PokemonServiceProtocol {
    typealias url = String
    
    func getPokemonDetail(id pokemonId: UInt) async throws -> PokemonDetail
    func getSpecies(from speciesUrl: url) async throws -> SpeciesRawResponse
    func getRawEvolution(from evolutionUrl: url) async throws -> EvolutionRawResponse
}

struct SpeciesRawResponse: Codable {
    let evolutionChain: ChainUrl?
    let id:UInt

    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
        case id
    }
}

struct ChainUrl: Codable {
    let url: String
}

enum PokemonServiceError: Error {
    case invalidServerResponse
    case emptyEvolution
    case decodingError
    
}

class PokemonService:PokemonServiceProtocol {
    
    func getPokemonDetail(id pokemonId: UInt) async throws -> PokemonDetail {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonId)")!
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw "\(#function) invalidServerResponse"
        }
        guard let decodedResponse = try? JSONDecoder().decode(PokemonDetail.self, from: data) else {
            throw "Can't decode \(#function)."
        }
        return decodedResponse
    }
    
    func getSpecies(from speciesUrl: url) async throws -> SpeciesRawResponse {
        let url = URL(string: speciesUrl)!
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw "\(#function) invalidServerResponse"
        }
        guard let decodedResponse = try? JSONDecoder().decode(SpeciesRawResponse.self, from: data) else {
            throw "Can't decode \(#function)."
        }
        return decodedResponse
    }
    
    func getRawEvolution(from evolutionUrl: url) async throws -> EvolutionRawResponse {
        guard let url = URL(string: evolutionUrl) else {
            throw PokemonServiceError.emptyEvolution
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw "\(#function) invalidServerResponse"
        }
        guard let decodedResponse = try? JSONDecoder().decode(EvolutionRawResponse.self, from: data) else {
            throw "Can't decode \(#function)."
        }
        return decodedResponse
    }
    
}
