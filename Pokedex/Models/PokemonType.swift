//
//  PokemonTypes.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 24/1/2566 BE.
//

import Foundation
import SwiftUI

// MARK: - TypeElement

struct TypeElement: Codable, Identifiable, Hashable {
    var id: UUID {
        UUID()
    }

    let slot: UInt
    let type: PokemonType

    // MARK: - PokemonType

    struct PokemonType: Codable, Hashable {
        let name: TypeKeys
        var typeDetail: TypeDetail {
            TypeElement.getDisplayPokemonType(typeName: name)
        }
    }
}

extension TypeElement {
    enum TypeKeys: String, Codable, CaseIterable {
        case grass
        case poison
        case water
        case steel
        case rock
        case psychic
        case normal
        case ice
        case ground
        case ghost
        case flying
        case fire
        case fighting
        case fairy
        case electric
        case dragon
        case dark
        case bug
    }

    // MARK: - TypeDetail

    struct TypeDetail {
        let typeName: String
        var image: Image {
            Image("Pokemon_Type_Icon_\(typeName.capitalized)")
        }

        var color: Color {
            Color("Pokemon_Type_Color_\(typeName.capitalized)")
        }
    }

    static func getDisplayPokemonType(typeName: TypeKeys) -> TypeDetail {
        return TypeDetail(typeName: typeName.rawValue)
    }
}
