//
//  DetailView.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 15/1/2566 BE.
//

import SDWebImageSwiftUI
import SwiftUI

struct DetailView: View {
    @EnvironmentObject var model: Model
    @State private var loading = true
    var pokemonId: UInt

    var body: some View {
        let pokemon = model.pokemon

        HStack {
            if !loading {
                ScrollView {
                    VStack {
                        AsyncImage(url: URL(string: pokemon!.detail.sprites.frontDefault ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 200, height: 200, alignment: .center)
                        VStack {
                            Text(pokemon!.detail.name.capitalized)
                                .font(.title)
                                .fontWeight(.bold)

                            Text("# \(pokemon!.detail.id)")
                                .font(.title2)
                            HStack {
                                ForEach(pokemon!.detail.types) {
                                    item in TypeCard(name: item.type.name.rawValue, icon: item.type.typeDetail.image, borderColor: item.type.typeDetail.color)
                                }
                            }
                            HStack {
                                DetailColumn(title: "Weight", value: pokemon?.detail.convertedWeight ?? "")
                                Rectangle()
                                    .frame(width: 1)
                                    .padding(.horizontal, 8)
                                DetailColumn(title: "Height", value: pokemon?.detail.convertedHeight ?? "")
                            }
                            Group {
                                Text("Base Stats")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                ForEach(pokemon!.detail.stats, id: \.self) {
                                    item in
                                    StatRow(status: item, barColor: pokemon!.detail.types[0].type.typeDetail.color)
                                }
                            }
                            Group {
                                if pokemon!.detail.sprites.frontDefault != nil {
                                    Text("Sprites")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                HStack {
                                    SpriteColumn(title: "Normal", frontUrl: pokemon?.detail.sprites.frontDefault, backUrl: pokemon?.detail.sprites.backDefault)
                                    SpriteColumn(title: "Shiny", frontUrl: pokemon?.detail.sprites.frontShiny, backUrl: pokemon?.detail.sprites.backShiny)
                                }
                            }
                            if pokemon!.evolution.count > 0 {
                                Group {
                                    Text("Evolution")
                                        .font(.title2)
                                        .fontWeight(.bold)
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
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .cornerRadius(radius: 30, corners: [.topLeft, .topRight])
                    }
                    .padding(.top, 44 + 20)
                    .background(pokemon?.detail.types[0].type.typeDetail.color)
                }
            } else {
                Text("Loading")
            }
        }
        .task {
            do {
                try await model.loadPokemon(id: pokemonId)

            } catch {
                print(error)
            }
            await MainActor.run {
                loading = false
            }
        }
        .background(.white)
        .ignoresSafeArea()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let model = Model()
    static var previews: some View {
        DetailView(pokemonId: 6)
            .environmentObject(model)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        DetailView(pokemonId: 1)
            .environmentObject(model)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        DetailView(pokemonId: 6)
            .environmentObject(model)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE")
    }
}
