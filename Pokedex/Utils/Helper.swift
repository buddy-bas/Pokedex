//
//  Helper.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 26/1/2566 BE.
//

import Foundation

// MARK: - Data
extension Data {
    func printJSON() {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8)
        {
            print(JSONString)
        }
    }
}

// MARK: - String
extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
