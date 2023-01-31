//
//  ListViewItem.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 31/1/2566 BE.
//

import SwiftUI

struct ListViewItem: View {
    var body: some View {
        HStack {
            Text("1000")
                .font(.subheadline)
                .fontWeight(.bold)
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .frame(width: 40, height: 40)
            .padding(4)

            .clipShape(Circle())
            Text("kdfopjsdopkdsocsdopkcopsdkcodskc")
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)
                .frame(width: 100)
            Spacer()
            HStack(spacing: 4) {
                Image("Pokemon_Type_Icon_Bug")
                    .resizable()
                    .frame(width: 20, height: 20)
                Image("Pokemon_Type_Icon_Fighting")
                    .resizable()
                    .frame(width: 20, height: 20)
            }

            Spacer()
            Image(systemName: "star")
                .resizable()
                .frame(width: 20, height: 20)
        }
      
    }
}

struct ListViewItem_Previews: PreviewProvider {
    static var previews: some View {
        ListViewItem()
    }
}
