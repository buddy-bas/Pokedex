//
//  ContentView.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 14/1/2566 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DetailView(pokemonId: 6)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let model = Model()
    static var previews: some View {
        ContentView()
            .environmentObject(model)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        ContentView()
            .environmentObject(model)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        ContentView()
            .environmentObject(model)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE 3")
    }
}
