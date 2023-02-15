//
//  ListViewItem.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 31/1/2566 BE.
//

import SwiftUI

struct ListViewItem: View,Equatable {
    let services = Services()
    
    let name: String
    let detailUrl: String
    let pokemonId: Int
    
    @Binding var isSet:Bool
    
    @State private var imageUrl = ""
    @State private var types: [TypeElement] = []
    
    var body: some View {
        let _ = Self._printChanges()

        HStack {
            Text("\(pokemonId)")
                .font(.subheadline)
                .fontWeight(.bold)
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .frame(width: 40, height: 40)
            .padding(4)
            Text(name)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)
                .frame(width: 100)
            Spacer()
            HStack(spacing: 4) {
                ForEach(types) { item in
                    item.type.typeDetail.image
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            Spacer()
            Button {
            } label: {
                Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                    .labelStyle(.iconOnly)
                    .foregroundColor(isSet ? .yellow : .gray)
            }
            .onTapGesture {
                isSet.toggle()
            }
        }
        .task {
            do {
                let  decodedResponse = try await services.pokemonService.getPokemonDetail(from: detailUrl)
                types = decodedResponse.types
                imageUrl = decodedResponse.sprites.frontDefault ?? ""

            } catch {
                print(error)
            }
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.isSet == rhs.isSet
    }

}

struct ListViewItem_Previews: PreviewProvider {
    static var previews: some View {
        ListViewItem(name: "TEST", detailUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", pokemonId: 1, isSet: .constant(false))
    }
}
