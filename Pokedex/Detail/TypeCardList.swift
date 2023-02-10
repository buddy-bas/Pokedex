//
//  TypeCardList.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 29/1/2566 BE.
//

import SwiftUI

struct TypeCardList: View {
    @EnvironmentObject var pokemonState: PokemonState
    var body: some View {
        HStack(spacing: 8) {
            ForEach(pokemonState.pokemon?.detail.types ?? []) {
                item in
                VStack {
                    TypeCard(name: item.type.name.rawValue, icon: item.type.typeDetail.image, borderColor: item.type.typeDetail.color)
                }
            }
        }
    }
}

struct TypeCardList_Previews: PreviewProvider {
    static let model = Model()
    static var previews: some View {
        TypeCardList()
            .environmentObject(model)
    }
}
