//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 14/1/2566 BE.
//


import SwiftUI

@main
struct PokedexApp: App {
    @StateObject private var model = Model(services: Services())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
