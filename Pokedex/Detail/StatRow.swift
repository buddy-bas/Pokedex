//
//  StatRow.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 28/1/2566 BE.
//

import SwiftUI

struct StatRow: View {
    let status: StatElement
    let barColor: Color
    var body: some View {
        HStack {
            Text(status.stat.acronym)
                .textCase(.uppercase)
                .frame(maxWidth: 55, alignment: .leading)
            StatBar(statValue: Double(status.baseStat), color: barColor)
            Text("\(status.baseStat)")
        }
    }
}

struct StatRow_Previews: PreviewProvider {
    static var previews: some View {
        StatRow(status: StatElement(baseStat: 30, stat: StatStat(name: "attack")), barColor: .red)
    }
}
