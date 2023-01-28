//
//  Evolution.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 26/1/2566 BE.
//

import Foundation

// MARK: - EvolutionRawResponse

struct EvolutionRawResponse: Codable {
    let chain: Chain
}

// MARK: - Chain

struct Chain: Codable {
    let evolvesTo: [Chain]
    let species: Species

    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case species
    }
}

// MARK: - Evolution

struct Evolution: Codable, Hashable, Identifiable {
    let id:UInt
    let name: String
    let spriteUrl: String
}
