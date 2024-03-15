//
//  PokemonList.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

class PokemonListResponseModel: Codable{
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResponseModel]
}
