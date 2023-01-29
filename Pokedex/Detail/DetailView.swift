//
//  DetailView.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 15/1/2566 BE.
//

import SDWebImageSwiftUI
import SwiftUI

struct DetailView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @EnvironmentObject var model: Model
    @State private var loading = true
    var pokemonId: UInt

    var body: some View {
        let pokemon = model.pokemon

        HStack {
            if !loading {
                ScrollView {
                    VStack(spacing: 0) {
                        GeometryReader { geo in
                            AsyncImage(url: URL(string: pokemon!.detail.sprites.frontDefault ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .scaledToFit()
                            .padding(.top, safeAreaInsets.top)
                            .padding(.bottom, 38)
                            .frame(width: geo.size.width, height: GeometryHelper.getHeightForHeaderImage(geo), alignment: .center)
                            .background(pokemon!.detail.types[0].type.typeDetail.color)
                            .offset(x: 0, y: GeometryHelper.getOffsetForHeaderImage(geo))
                        }
                        .frame(height: 300)

                        VStack(spacing: 0) {
                            Text(pokemon!.detail.name.capitalized)
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top, 24)
                            Text("# \(pokemon!.detail.id)")
                                .font(.title3)
                            TypeCardList()
                                .padding(.vertical, 16)
                            HStack {
                                DetailColumn(title: "Weight", value: pokemon!.detail.convertedWeight)
                                Rectangle()
                                    .frame(width: 2)
                                DetailColumn(title: "Height", value: pokemon!.detail.convertedHeight)
                            }
                            VStack(spacing: 0) {
                                Text("Base Stats")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.top, 24)
                                    .padding(.bottom, 8)

                                ForEach(pokemon!.detail.stats, id: \.self) {
                                    item in
                                    StatRow(status: item, barColor: pokemon!.detail.types[0].type.typeDetail.color)
                                        .padding(.top, 8)
                                }
                            }
                            .padding(.horizontal, 24)
                            VStack(spacing: 0) {
                                if pokemon!.detail.sprites.frontDefault != nil {
                                    Text("Sprites")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.top, 24)
                                }
                                HStack {
                                    SpriteColumn(title: "Normal", frontUrl: pokemon?.detail.sprites.frontDefault, backUrl: pokemon?.detail.sprites.backDefault)
                                    SpriteColumn(title: "Shiny", frontUrl: pokemon?.detail.sprites.frontShiny, backUrl: pokemon?.detail.sprites.backShiny)
                                }
                                .padding(.top)
                            }
                            EvolutionList()
                                .padding(.top, 24)
                        }
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .cornerRadius(radius: 30, corners: [.topLeft, .topRight])
                        .offset(y: -30)
                    }
                    .ignoresSafeArea()
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
        DetailView(pokemonId: 6)
            .environmentObject(model)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        DetailView(pokemonId: 6)
            .environmentObject(model)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE")
    }
}
