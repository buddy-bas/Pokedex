//
//  StatBar.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 15/1/2566 BE.
//

import SwiftUI

struct StatBar: View {
    @State private var showStat = false

    var statValue: Double
    let color: Color
    var percentStatValue: Double {
        guard statValue < 255 else {
            return 255
        }
        return Double(statValue * 250 / 255)
    }

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(.systemGray5))
            RoundedRectangle(cornerRadius: 3)
                .fill(color)
                .frame(width: showStat ? percentStatValue : 0, alignment: .leading)
                .animation(Animation.easeOut(duration: 1.5), value: showStat)
        }
        .frame(width: 250, height: 12)
        .onAppear {
            showStat.toggle()
        }
    }
}

struct StatBar_Previews: PreviewProvider {
    static var previews: some View {
        StatBar(statValue: 200, color: .green)
    }
}
