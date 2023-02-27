//
//  EvolutionList.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 29/1/2566 BE.
//

import SwiftUI

struct EvolutionList: View {
    @EnvironmentObject var pokemonState: PokemonState
    
    let singleColumn = [
        GridItem(.fixed(120)),
    ]
    let doubleColumns = [
        GridItem(.fixed(120)),
        GridItem(.fixed(120)),
    ]
    let tripleColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var columns: [GridItem] {
        switch pokemonState.pokemon!.evolution.count {
        case 1:
           return singleColumn

        case 2:
            return doubleColumns

        default:
            return tripleColumns
        }
    }

    var body: some View {
            LazyVGrid(columns: columns, alignment: .center) {
                ForEach(Array(pokemonState.pokemon!.evolution.enumerated()), id: \.element.spriteUrl) { _, item in
                    EvolutionColumn(evolution: item)
                }
            }
        }
}

struct EvolutionList_Previews: PreviewProvider {
    static let model = Model()
    static var previews: some View {
        EvolutionList().environmentObject(model)
    }
}
