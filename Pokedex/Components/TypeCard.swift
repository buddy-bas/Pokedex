//
//  ElementCard.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 24/1/2566 BE.
//

import SwiftUI

struct TypeCard: View {
    let name: String
    let icon: Image
    let borderColor: Color
    var body: some View {
        HStack {
            icon
                .resizable()
                .frame(width: 25, height: 25)
            Text(name.capitalized)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .frame(width: 120, height: 40)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor, lineWidth: 1)
        )
    }
}

struct TypeCard_Previews: PreviewProvider {
    static var previews: some View {
        TypeCard(name: "grassssss", icon: Image("Pokemon_Type_Icon_Grass"), borderColor: Color.red)
    }
}
