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
            .frame(width: 80, height: 80)
            Text(evolution.name.capitalized)
                .font(.title3)
        }
    }
}

struct EvolutionColumn_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionColumn(evolution: Evolution(id: 1, name: "test", spriteUrl: "test"))
    }
}
