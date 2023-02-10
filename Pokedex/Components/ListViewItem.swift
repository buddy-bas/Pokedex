//
//  ListViewItem.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 31/1/2566 BE.
//

import SwiftUI

struct ListViewItem: View {
    let name: String
    let detailUrl: String
    let pokemonId: Int
    var showFavoriteIcon: Bool = true
    @State private var imageUrl = ""
    @State private var isSet = false
    @State private var types:[TypeElement] = []
    @EnvironmentObject var model:Model
    
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
            .clipShape(Circle())
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
            if showFavoriteIcon {
                Spacer()
                FavoriteButton(isSet: $isSet)
            }
        }
        .task {
            do {
                let url = URL(string: detailUrl)!
                let (data, response) = try await URLSession.shared.data(from: url)

                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw "\(#function) invalidServerResponse"
                }
                guard let decodedResponse = try? JSONDecoder().decode(PokemonDetail.self, from: data) else {
                    throw "Can't decode \(#function)."
                }
                types =  decodedResponse.types
                imageUrl = decodedResponse.sprites.frontDefault ?? ""


            } catch {
                print(error)
            }
        }
    }
}

struct ListViewItem_Previews: PreviewProvider {
    static var previews: some View {
        ListViewItem(name: "TEST", detailUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", pokemonId: 1)
    }
}
