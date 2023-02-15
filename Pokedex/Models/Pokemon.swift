//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 17/1/2566 BE.
//

import Foundation

// MARK: - Pokemon

struct Pokemon: Codable {
    var detail: PokemonDetail
    var evolution: [Evolution]
}

// MARK: - PokemonListItem

struct PokemonListItem: Codable, Identifiable, Hashable {
    var id: UUID {
        UUID()
    }
    let name, url: String
    var pokemonId: Int?
    var isFavorite: Bool?
    var favoritedDate: Date?
    
}

// MARK: - PokemonList

struct PokemonList: Codable {
    let count: Int
    var results: [PokemonListItem]
    var next: String
}

// MARK: - PokemonDetail

struct PokemonDetail: Codable {
    let id: UInt
    let name: String
    let species: Species
    let types: [TypeElement]
    let stats: [StatElement]
    let sprites: Sprites
    let weight: UInt
    let height: UInt
    var convertedWeight: String {
        return "\(String(format: "%.1f", Double(weight) * 0.1)) kg"
    }

    var convertedHeight: String {
        return "\(String(format: "%.2f", Double(height) * 0.1)) m"
    }
}

// MARK: - Species

struct Species: Codable {
    let id: UInt?
    let name, url: String
}

// MARK: - Sprites

struct Sprites: Codable {
    let backDefault, backShiny, frontDefault, frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - StatElement

struct StatElement: Codable, Hashable, Identifiable {
    var id: UUID {
        UUID()
    }

    let baseStat: UInt32
    let stat: StatStat

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

// MARK: - StatStat

struct StatStat: Codable, Hashable {
    let name: String
    var acronym: String {
        switch name {
        case "attack":
            return "atk"
        case "defense":
            return "def"
        case "special-attack":
            return "sp.atk"
        case "special-defense":
            return "sp.def"
        case "speed":
            return "spd"
        default:
            return name
        }
    }
}
