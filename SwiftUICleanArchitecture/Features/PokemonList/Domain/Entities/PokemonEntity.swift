//
//  PokemonEntity.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 15/03/2024.
//

import Foundation

struct PokemonEntity: Hashable{
    var id: Int
    var name: String
    var imageURL: String
    var image: Data?
    
    init(id: Int, name: String, imageURL: String, image: Data?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.image = image
    }
    
    init?(pokemonResponse: PokemonResponseModel) {
        guard let urlComponents = URLComponents(string: pokemonResponse.url),
              let idString = urlComponents.path.split(separator: "/").last,
              let id = Int(idString) else {
                  return nil
              }
        self.id = id
        self.name = pokemonResponse.name
        self.imageURL = Constants.APIEndpoint.getPokemonImage(id: id).url?.absoluteString ?? ""
        self.image = pokemonResponse.image
    }
    
    init?(pokemonDetailResponse: PokemonDetailResponseModel) {
        self.id = pokemonDetailResponse.id
        self.name = pokemonDetailResponse.name
//        self.imageURL = Constants.APIEndpoint.getPokemonImage(id: id).url?.absoluteString ?? ""
        self.imageURL = Constants.APIEndpoint.getPokemonImage(id: pokemonDetailResponse.id).url?.absoluteString ?? ""
        self.image = pokemonDetailResponse.image
    }
    
    init?(pokemonObject: PokemonSwiftDTO) {
        guard let urlComponents = URLComponents(string: pokemonObject.url),
              let idString = urlComponents.path.split(separator: "/").last,
              let id = Int(idString) else {
                  return nil
              }
        self.id = id
        self.name = pokemonObject.name
        self.imageURL = Constants.APIEndpoint.getPokemonImage(id: id).url?.absoluteString ?? ""
        self.image = pokemonObject.image
    }
}

extension PokemonEntity {
//    static let MOCK_POKEMON_ENTITY = PokemonEntity
}
