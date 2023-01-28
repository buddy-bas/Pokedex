//
//  Service.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 27/1/2566 BE.
//

import Foundation

struct Services {
    let pokemonService: PokemonService
}

extension Services {
    init() {
        self.init(pokemonService: PokemonService())
    }
}
