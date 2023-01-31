//
//  HomeView.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 31/1/2566 BE.
//

import SwiftUI

struct Tt: Identifiable {
    var id: UUID {
        UUID()
    }
    
    var name: String
}

struct HomeView: View {
    let data = [Tt(name: "test"), Tt(name: "test"), Tt(name: "test")]
    var body: some View {
        List(data) { _ in
            ListViewItem()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
