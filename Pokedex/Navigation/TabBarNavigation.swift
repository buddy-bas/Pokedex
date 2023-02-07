//
//  TabBarNavigation.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 31/1/2566 BE.
//

import SwiftUI

struct TabBarNavigation: View {
    var body: some View {
        TabView {
                HomeView()
            .tabItem {
                Image(systemName: "house.fill")
                Text("Pokémon")
            }

            Text("Bookmark Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorite")
                }
        }
    }
}

struct TabBarNavigation_Previews: PreviewProvider {
    static let model = Model()
    static var previews: some View {
        TabBarNavigation()
            .environmentObject(model)
    }
}
