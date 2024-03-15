//
//  PokemonDetailEntity.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

struct PokemonDetailEntity{
    let pokemon: PokemonEntity
    let height: Int
    let weight: Int
    
    init?(pokemonDetailResponse: PokemonDetailResponseModel) {
        guard let pokemon = PokemonEntity(pokemonDetailResponse: pokemonDetailResponse) else {
            return nil
        }
        
        self.pokemon = pokemon
        self.height = pokemonDetailResponse.height
        self.weight = pokemonDetailResponse.weight
    }
}
