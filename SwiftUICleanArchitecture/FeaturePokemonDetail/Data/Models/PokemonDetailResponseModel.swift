//
//  PokemonDetailResponseModel.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

struct PokemonDetailResponseModel: Codable{
    let id: Int
    let name: String
    let height: Int
    let weight: Int
}
