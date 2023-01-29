//
//  EvolutionList.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 29/1/2566 BE.
//

import SwiftUI

struct EvolutionList: View {
    @EnvironmentObject var model: Model
    var body: some View {
        let pokemon = model.pokemon
        if pokemon?.evolution.count ?? 0 > 0 {
            VStack(spacing:0){
                Text("Evolution")
                    .font(.title3)
                    .fontWeight(.semibold)
                HStack {
                    ForEach(Array(pokemon!.evolution.enumerated()), id: \.element) {
                        index, item in
                        EvolutionColumn(evolution: item)
                        if index < (pokemon!.evolution.count - 1) {
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
