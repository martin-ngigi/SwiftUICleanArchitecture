//
//  Pokemon.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation


class PokemonResponseModel : Decodable, Encodable {
    let name: String
    let url: String
}
