//
//  DetailColumn.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 15/1/2566 BE.
//

import SwiftUI

struct DetailColumn: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 0) {
            Text(value)
                .font(.title3)
                .fontWeight(.medium)
            Text(title)
                .font(.subheadline)
                .padding(.top, 4)
        }
        .frame(width: 100)
    }
}

struct DetailColumn_Previews: PreviewProvider {
    static var previews: some View {
        DetailColumn(title: "Weight", value: "160 lbs")
    }
}
