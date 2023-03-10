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
        VStack(spacing: 0) {
            if frontUrl != nil || backUrl != nil {
                Text(title)
                    .font(.title3)
                    .fontWeight(.medium)
            }
            if frontUrl != nil {
                VStack{
                    Text("Front")
                        .spriteModifier()
                        .padding(.top, 4)
                    AsyncImage(url: URL(string: frontUrl!)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                }
                .spriteModifier()
            }
            if backUrl != nil {
                VStack{
                    Text("Back")
                        .spriteModifier()
                    AsyncImage(url: URL(string: backUrl!)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                }
                .spriteModifier()
                
            }
        }
    }
}

extension VStack {
    func spriteModifier() -> some View {
        self
            .frame(width: 100, height: 100)
    }
}

private extension Text {
    func spriteModifier() -> some View {
        font(.title3)
    }
}

struct SpriteColumn_Previews: PreviewProvider {
    static var previews: some View {
        SpriteColumn(title: "Normal", frontUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png", backUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png")
    }
}
