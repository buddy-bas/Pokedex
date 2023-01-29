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
    let width: Double

    func percentStatValue(_ w: Double) -> Double {
        guard statValue < 255 else {
            return 255
        }
        return Double((statValue * w) / 255)
    }

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(.systemGray5))
            RoundedRectangle(cornerRadius: 3)
                .fill(color)
                .frame(width: showStat ? percentStatValue(width) : 0, alignment: .leading)
                .animation(Animation.easeOut(duration: 1.5), value: showStat)
        }
        .frame(width: width * 1, height: 12)
        .onAppear {
            showStat.toggle()
        }
    }
}

struct StatBar_Previews: PreviewProvider {
    static var previews: some View {
        StatBar(statValue: 100, color: .green, width: 200)
    }
}
