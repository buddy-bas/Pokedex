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
        VStack {
            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
            Text(title)
                .font(.title3)
        }
    }
}

struct DetailColumn_Previews: PreviewProvider {
    static var previews: some View {
        DetailColumn(title: "Weight", value: "160 lbs")
    }
}
