//
//  FavoriteGridItem.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 12/2/2566 BE.
//

import SwiftUI

struct FavoriteGridItem: View {
    let detailUrl: String
    let name: String
    let services = Services()

    @State private var imageUrl = ""
    @State private var types: [TypeElement] = []

    var body: some View {
        VStack {
            Text(name)
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(2)
            HStack {
                HStack(spacing: 4) {
                        ForEach(types) { item in
                            item.type.typeDetail.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                }
                Spacer()
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: 80, height: 80)
            }
        }
        .transition(.move(edge: .leading))
        .frame(height: 160)
        .padding(.trailing, 10)
        .padding(.top, 10)
        .padding(.leading, 16)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(red: 246 / 255, green: 246 / 255, blue: 246 / 255)))
        .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 16))

        .task {
            do {
                let decodedResponse = try await services.pokemonService.getPokemonDetail(from: detailUrl)
                types = decodedResponse.types
                imageUrl = decodedResponse.sprites.frontDefault ?? ""

            } catch {
                print(error)
            }
        }
    }
}

struct FavoriteGridItem_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteGridItem(detailUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", name: "TEST")
    }
}
