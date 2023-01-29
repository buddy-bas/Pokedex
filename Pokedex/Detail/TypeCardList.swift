//
//  TypeCardList.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 29/1/2566 BE.
//

import SwiftUI

struct TypeCardList: View {
    @EnvironmentObject var model:Model
    var body: some View {
        let pokemon = model.pokemon
        HStack(spacing: 8) {
            ForEach(pokemon?.detail.types ?? []) {
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
