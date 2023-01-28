//
//  SpriteColumn.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 15/1/2566 BE.
//

import SwiftUI

struct SpriteColumn: View {
    let title: String
    let frontUrl: String?
    let backUrl: String?

    var body: some View {
        VStack {
            if frontUrl != nil || backUrl != nil {
                Text(title)
            }
            if frontUrl != nil {
                Text("Front")
                AsyncImage(url: URL(string: frontUrl!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .spriteModifier()
            }
            if backUrl != nil {
                Text("Back")
                AsyncImage(url: URL(string: backUrl!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .spriteModifier()
            }
        }
    }
}

extension AsyncImage {
    func spriteModifier() -> some View {
        scaledToFit()
            .frame(width: 100, height: 100)
    }
}

struct SpriteColumn_Previews: PreviewProvider {
    static var previews: some View {
        SpriteColumn(title: "Normal", frontUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", backUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
    }
}
