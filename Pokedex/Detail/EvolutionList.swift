//
//  EvolutionList.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 29/1/2566 BE.
//

import SwiftUI

struct EvolutionList: View {
    @EnvironmentObject var pokemonState: PokemonState
    var body: some View {
        if pokemonState.pokemon?.evolution.count ?? 0 > 0 {
            VStack(spacing:0){
                Text("Evolution")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textCase(.uppercase)
                HStack {
                    ForEach(Array(pokemonState.pokemon!.evolution.enumerated()), id: \.element) {
                        index, item in
                        EvolutionColumn(evolution: item)
                        if index < (pokemonState.pokemon!.evolution.count - 1) {
                            Image(systemName: "arrow.right")
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                    }
                }
                .padding(.top,8)
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
