//
//  PokemonEntity.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

struct PokemonEntity: Hashable{
    let id: Int
    let name: String
    let imageURL: String
    
    init?(pokemonResponse: PokemonResponseModel) {
        guard let urlComponents = URLComponents(string: pokemonResponse.url),
              let idString = urlComponents.path.split(separator: "/").last,
              let id = Int(idString) else {
                  return nil
              }
        self.id = id
        self.name = pokemonResponse.name
        self.imageURL = Constants.APIEndpoint.getPokemonImage(id: id).url?.absoluteString ?? ""
    }
    
    init?(pokemonDetailResponse: PokemonDetailResponseModel) {
        self.id = pokemonDetailResponse.id
        self.name = pokemonDetailResponse.name
        self.imageURL = Constants.APIEndpoint.getPokemonImage(id: id).url?.absoluteString ?? ""
    }
}
