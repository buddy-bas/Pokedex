//
//  EvolutionColumn.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 28/1/2566 BE.
//

import SwiftUI

struct EvolutionColumn: View {
    let evolution: Evolution
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: evolution.spriteUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            
            Text(evolution.name.capitalized)
                .font(.title3)
        }
        .frame(width: 100, height: 100)
    }
}

struct EvolutionColumn_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionColumn(evolution: Evolution(id: 1, name: "test", spriteUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png"))
    }
}
