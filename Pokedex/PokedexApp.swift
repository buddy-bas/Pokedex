//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 14/1/2566 BE.
//

import SDWebImageSVGCoder
import SwiftUI

@main
struct PokedexApp: App {
    @StateObject private var model = Model(services: Services())
    init() {
        setUpDependencies() // Initialize SVGCoder
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}

// Initialize SVGCoder
private extension PokedexApp {
    func setUpDependencies() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
}
