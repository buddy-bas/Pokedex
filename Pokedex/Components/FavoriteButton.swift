//
//  FavoriteButton.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 7/2/2566 BE.
//

import SwiftUI

struct FavoriteButton: View {
    
    @Binding var isSet: Bool
    var body: some View {
        Button {
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
        .onTapGesture {
            isSet.toggle()
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(false))
    }
}
