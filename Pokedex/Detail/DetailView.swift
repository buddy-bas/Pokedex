//
//  DetailView.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 15/1/2566 BE.
//


import SwiftUI

struct DetailView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @EnvironmentObject private var pokemonState: PokemonState
    @EnvironmentObject private var pokemonListState: PokemonListState
    @EnvironmentObject private var model: Model
    
    @State private var loading = true
    
    var url: String
    
    var body: some View {
        let _ = Self._printChanges()
        HStack {
            if !loading {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        GeometryReader { geo in
                            AsyncImage(url: URL(string: pokemonState.pokemon!.detail.sprites.frontDefault ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .scaledToFit()
                            .padding(.top, safeAreaInsets.top)
                            .padding(.bottom, 38)
                            .frame(width: geo.size.width, height: GeometryHelper.getHeightForHeaderImage(geo), alignment: .center)
                            .background(pokemonState.pokemon!.detail.types[0].type.typeDetail.color)
                            .offset(x: 0, y: GeometryHelper.getOffsetForHeaderImage(geo))
                        }
                        .frame(height: 300)

                        VStack(spacing: 0) {
                            Text(pokemonState.pokemon!.detail.name.capitalized)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top, 24)
                            Text("# \(pokemonState.pokemon!.detail.id)")
                                .font(.title3)
                            TypeCardList()
                                .padding(.vertical, 16)
                            HStack {
                                DetailColumn(title: "Weight", value: pokemonState.pokemon!.detail.convertedWeight)
                                Rectangle()
                                    .frame(width: 2)
                                DetailColumn(title: "Height", value: pokemonState.pokemon!.detail.convertedHeight)
                            }
                            VStack(spacing: 0) {
                                Text("Base Stats")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .textCase(.uppercase)
                                    .padding(.top, 24)
                                    .padding(.bottom, 8)

                                ForEach(pokemonState.pokemon!.detail.stats, id: \.self) {
                                    item in
                                    StatRow(status: item, barColor: pokemonState.pokemon!.detail.types[0].type.typeDetail.color)
                                        .padding(.top, 8)
                                }
                            }
                            .padding(.horizontal, 24)
                            VStack(spacing: 0) {
                                if pokemonState.pokemon!.detail.sprites.frontDefault != nil {
                                    Text("Sprites")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .textCase(.uppercase)
                                        .padding(.top, 24)
                                }
                                HStack {
                                    SpriteColumn(title: "Normal", frontUrl: pokemonState.pokemon?.detail.sprites.frontDefault, backUrl: pokemonState.pokemon?.detail.sprites.backDefault)
                                    SpriteColumn(title: "Shiny", frontUrl: pokemonState.pokemon?.detail.sprites.frontShiny, backUrl: pokemonState.pokemon?.detail.sprites.backShiny)
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
                }

            } else {
                Text("Loading")
            }
        }
        .task {
            do {
                try await model.loadPokemon(from: url)
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
        DetailView(url: "https://pokeapi.co/api/v2/pokemon/10")
            .environmentObject(model)
            .environmentObject(model.pokemonListState)
            .environmentObject(model.pokemonState)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        DetailView(url: "https://pokeapi.co/api/v2/pokemon/10")
            .environmentObject(model)
            .environmentObject(model.pokemonListState)
            .environmentObject(model.pokemonState)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        DetailView(url: "https://pokeapi.co/api/v2/pokemon/10")
            .environmentObject(model)
            .environmentObject(model.pokemonListState)
            .environmentObject(model.pokemonState)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE")
    }
}
