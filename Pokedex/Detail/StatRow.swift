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
        GeometryReader { geo in
            HStack(spacing:0) {
                Text(status.stat.acronym)
                    .textCase(.uppercase)
                    .font(.system(size:geo.size.width * 0.04,weight: .medium))
                    .frame(width: geo.size.width * 0.165, alignment: .leading)
                StatBar(statValue: Double(status.baseStat), color: barColor, width: geo.size.width * 0.735)
                Text("\(status.baseStat)")
                    .font(.system(size:geo.size.width * 0.04,weight: .medium))
                    .frame(width: geo.size.width * 0.1, alignment: .trailing)
                    
            }
        }
        .frame(height: 20)
    }
}

struct StatRow_Previews: PreviewProvider {
    static var previews: some View {
        StatRow(status: StatElement(baseStat: 32, stat: StatStat(name: "attack")), barColor: .red)
    }
}
